class SearchController < ApplicationController
  # before_action :set_members, only: [:member, :create, :show]
  before_action :set_member, only: [:new, :member, :create, :update]
  before_action :set_search, only: [:show, :update]
  before_action :search_params, only: [:create, :update]

  def index
  end

  # GET /search/new
  def new
    @search = Search.new
  end

  def member
  	@search = Search.new
  	@search.query = @member.heading
  	@members = Member.search(@member.heading).exclude(params[:id]).includes(:friends)
  	@current = @member.id
  end

  def show
    if @search
      me = @search.member_id
      @member = Member.includes(:friends).find_by_id(me)
      @members = Member.search(@search.query, @search.id).exclude(me).includes(:friends)
      @members.each do |member|
        # To get common friends, do array intersection &
        # but skip if they are already friends
        if member.friends.pluck(:name).select{|x| x==@member.name}.length == 0
          common = member.friends.pluck(:name) & @member.friends.pluck(:name)
          if !common.empty?
            connection = []
            common.each {|cf| connection.push "#{@member.name} => #{cf} => #{member.name}"}
            member.friend_connection = connection.join("\n")
          end
        else
          member.friend_connection = "Already friends"
          member.search_score = 0
        end
      end
    end
  end
  
  # POST /search
  def create
    @search = Search.new(search_params)
    respond_to do |format|
      if @search.save
        format.html { redirect_to @search }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /search/1
  def update
    attributes = search_params.clone
    me = @search.member_id
    @member = Member.find_by_id(me)
    respond_to do |format|
      if @search.update(attributes)
        format.html { redirect_to @search }
      else
        format.html { render :show }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find_by_id(params[:id])
    end
    def set_members
      @members = Member.exclude(params[:id])
    end
    def set_search
      @search = Search.find_by_id(params[:id])
    end
    # Never trust parameters from the scary internet, only allow the white list through.
    def search_params
      params.require(:search).permit(:query, :member_id)
    end
end

class SearchController < ApplicationController
  before_action :set_member, only: [:new, :member, :create, :update]
  before_action :set_search, only: [:show, :update]
  before_action :search_params, only: [:create, :update]

  def index
  end

  # GET /search/new
  def new
    @search = Search.new
  end

  # GET /search/member/:id
  def member
    @search = Search.order("updated_at DESC").where("member_id = ?", params[:id]).limit(1).first
  	@search = Search.new(query: @member.heading, member_id: params[:id])  if @search.nil?
  	@members = Member.search(@search.query, @search.id).exclude(params[:id]).includes(:friends)
    format_search
  end

  # GET /search/:id
  def show
    puts "************************"
    puts "* GET /search:id (show) "
    puts "* search: #{@search.inspect}   *"
    puts "* current: #{@current} *"
    puts "************************"
    if @search
      me = @current = @search.member_id
      @member = Member.includes(:friends).find_by_id(me)
      @members = Member.search(@search.query, @search.id).exclude(me).includes(:friends)
      format_search
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
    @search = Search.order("updated_at DESC").where("member_id = ?", params[:id]).limit(1).first if @search.nil?
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

  def format_search
    results = []
    @members.each do |member|
      # To get common friends, do array intersection `&`
      # but skip if they are already friends
      if member.friends.select{|x| x.name == @member.name}.length == 0
        common = member.friends & @member.friends
        if !common.empty?
          connection = []
          common.each {|cf| connection.push "<a href='/members/#{@member.id}' class='highlight3'>#{@member.name}</a> &rarr; [<a href='/members/#{cf.id}' class='highlight1'>#{cf.name}</a>] &larr; <a href='/members/#{member.id}' class='highlight2'>#{member.name}</a>"}
          member.friend_connection = connection.join("<br/>")
          result = {:member => {id: member.id, name: member.name, connection: connection}}
        else
          member.friend_connection = "No connection found!"
          result = {:member => {id: member.id, name: member.name, connection: "No connection found!"}}
        end
      else
        member.friend_connection = "Already connected!"
        member.search_score = 1
        result = {:member => {id: member.id, name: member.name, connection: "Already connected!"}}
      end
      results.push(result)
    end
    @search.update_attributes(:results => results.to_json)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find_by_id(params[:id])
      @current = @member.id if @member
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

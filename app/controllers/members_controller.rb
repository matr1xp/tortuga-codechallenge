class MembersController < ApplicationController
  before_action :set_member, only: [:show, :edit, :update, :destroy]

  # GET /members
  def index
    @members = Member.includes(:friends).all
    if @member
      @current = @member.id 
    else
      @current = Member.first[:id] if Member.any?
    end
    if !@members.any?
      flash[:notice] = "No members found! Please create your first member now by clicking on button below."
    end
  end

  # GET /members/1
  def show
    me = params[:id]
    @member = Member.find(me)
    @friends = @member.friends
    @current = @member.id  
  end

  # GET /members/new
  def new
    @member = Member.new
    flash[:notice] = nil
  end

  # GET /members/1/edit
  def edit
    @current = @member.id  
  end

  # POST /members
  def create
    @member = Member.new(member_params)
    @member.short_url = ShorturlAt.shorten(member_params[:website])
    respond_to do |format|
      if @member.save
        format.html { redirect_to @member, notice: 'Member was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /members/1
  def update
    attributes = member_params.clone
    # We only process short urls if website changed
    if @member.website != attributes[:website]
       attributes[:short_url] = ShorturlAt.shorten(member_params[:website])
    end
    respond_to do |format|
      if @member.update(attributes)
        format.html { redirect_to @member, notice: 'Member was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /members/1
  def destroy
    @member.destroy
    respond_to do |format|
      format.html { redirect_to members_url, notice: 'Member was successfully deleted.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_member
      @member = Member.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :website, :heading, :short_url)
    end
end

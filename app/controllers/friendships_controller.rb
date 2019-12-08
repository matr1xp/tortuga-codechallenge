class FriendshipsController < ApplicationController
  before_action :set_members, only: [:select]
  before_action :set_friends, only: [:select]	
  
  # POST /friendships
  def create
  	respond_to do |format|
  	  result = true
  	  if (params[:friendship].is_a? Object) and (params[:friendship].is_a? Array)
        Member.find_by_id(params[:member_id]).friends.delete_all
        add_friend = params[:friendship].reject{|p| !p[:friend_id].is_a? String }
  	  	add_friend.each do |fr|
	  	  	permitted = fr.permit(:member_id, :friend_id)
	      	@friends = Friendship.new(permitted)
	      	begin
	  	    	result = @friends.save
	  	    rescue ActiveRecord::RecordNotUnique => e
	  	    	puts "*** Skipping record friend_id = #{permitted[:friend_id]}} ***"
	  	    end
	  	  end        
  	  end

      if result
        format.html { redirect_to "/members/#{params[:member_id]}", notice: 'Member friends successfully updated!' }
      else
        format.html { render :new }
      end
    end
  end

  def select
  	@friendship = Friendship.new
  	respond_to do |format|
  		format.html
  		format.js
  	end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_members
      @member = Member.find_by_id(params[:id])
      @members = Member.where.not(id: params[:id])
    end
    def set_friends
      @friends = Member.find_by_id(params[:id]).friends
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def member_params
      params.require(:member).permit(:name, :website, :heading, :short_url)
    end
    def friends_params
      # params.require(:friendship).permit(:member_id, :friend_id)
    end
end

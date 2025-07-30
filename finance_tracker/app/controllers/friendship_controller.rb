class FriendshipController < ApplicationController
  before_action :authenticate_user!

  def add_friend
    @friend = User.find_by(id: params[:friend_id])
    
    if @friend && !current_user.friends_with?(@friend) && @friend != current_user
      friendship = Friendship.create(user: current_user, friend: @friend)
      if friendship.persisted?
        flash[:notice] = "#{@friend.full_name} has been added to your friends."
      else
        flash[:alert] = "There was an error adding the friend."
      end
    else
      flash[:alert] = "Friend not found or already added."
    end
    
    redirect_to my_friends_path
  end

  def remove_friend
    @friend = User.find_by(id: params[:friend_id])
    
    if @friend && current_user.friends_with?(@friend)
      friendship = current_user.friendships.find_by(friend: @friend)
      if friendship&.destroy
        flash[:notice] = "#{@friend.full_name} has been removed from your friends."
      else
        flash[:alert] = "There was an error removing the friend."
      end
    else
      flash[:alert] = "Friend not found or not in your friends list."
    end
    
    redirect_to my_friends_path
  end
end

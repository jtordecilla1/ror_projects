class UsersController < ApplicationController
  before_action :authenticate_user!

  def show
    @user = User.find(params[:id])
    @tracked_stocks = @user.stocks
    @friends = @user.friends
  end
  
  def my_portfolio
    @tracked_stocks = current_user.stocks
  end

  def my_friends
    @friends = current_user.friends
  end

  def search_friend
    if params[:friend_name].present?
      # Use the CLASS method, not the instance method
      @friend = User.search_friend(params[:friend_name])
      
      # Handle edge cases
      if @friend == current_user
        @friend = nil
        @error_message = "That's you!"
      elsif @friend && current_user.friends_with?(@friend)
        @error_message = "#{@friend.full_name} is already your friend"
      end
      
      respond_to do |format|
        format.js { render 'friends/friend_search_result' }
      end
    else
      @friend = nil
      respond_to do |format|
        format.js { render 'friends/friend_search_result' }
      end
    end
  end

end

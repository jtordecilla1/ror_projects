class SessionsController < ApplicationController
  before_action :logged_in_redirect, only: [:new, :create]
  def new
     @user = User.new
  end

  def create
     @user = User.new 

    if params[:session].present?
      user = User.find_by(username: params[:session][:username])
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to root_path, notice: "Logged in successfully"
      else
        flash.now[:alert] = "There was something wrong with your login details"
        render 'new'
      end
    else
      flash.now[:alert] = "Please enter your login details"
      render 'new'
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to login_path, notice: "Logged out successfully"
  end
  
  private
  def logged_in_redirect
    if logged_in?
      redirect_to root_path, notice: "You are already logged in"
    end
  end
end
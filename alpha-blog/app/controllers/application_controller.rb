class ApplicationController < ActionController::Base
  allow_browser versions: :modern

  helper_method :current_user, :logged_in?, :require_user

  def current_user
    #We user memoization here
     if session[:user_id]
      @current_user ||= User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
      @current_user
    end
  end

  def logged_in?
    !!current_user
  end

  def require_user 
    if !logged_in?
      flash[:alert] = "You must be logged in to perform that action"
      redirect_to login_path
    end
  end
  
end
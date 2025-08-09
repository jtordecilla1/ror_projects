class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  helper_method :current_user, :logged_in?, :require_user

  def current_user
    @current_user ||= Student.find_by(id: session[:student_id]) if session[:student_id]
  end

  def logged_in?
    current_user.present?
  end

  def require_user
    unless logged_in?
      flash[:alert] = "You must be logged in to access this section."
      redirect_to login_path
    end
  end

  def require_same_user
    if current_user != @student
      flash[:alert] = "You can only edit your own profile."
      redirect_to student_path(current_user)
    end
  end
end

class SessionsController < ApplicationController
  before_action :redirect_if_logged_in, only: [:new, :create]
  before_action :require_user, only: [:destroy]

  def new
  end

  def create
    student = Student.find_by(email: params[:email])
    if student&.authenticate(params[:password])
      session[:student_id] = student.id
      redirect_to root_path, notice: "Logged in successfully."
    else
      flash.now[:alert] = "Invalid email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:student_id] = nil
    redirect_to root_path, notice: "Logged out successfully."
  end

  private
  def redirect_if_logged_in
    redirect_to root_path, alert: "You are already logged in." if session[:student_id]
  end
  
end

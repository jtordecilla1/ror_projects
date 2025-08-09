class StudentCoursesController < ApplicationController

  def create
    @course = Course.find(params[:course_id])
    if @course
      unless current_user.courses.include?(@course)
        current_user.courses << @course
        flash[:notice] = "You have successfully enrolled in #{@course.name}."
      else
        flash[:alert] = "You are already enrolled in #{@course.name}."
      end
    else
      flash[:alert] = "Course not found."
    end
    redirect_to courses_path
  end
end
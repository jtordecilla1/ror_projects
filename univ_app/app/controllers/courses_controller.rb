class CoursesController < ApplicationController
  before_action :require_user, only: [:index, :new]

  def index
    @courses = Course.all
  end

  def new
    @course = Course.new
  end

  def create
    @course = Course.new(course_params)
    if @course.save
      redirect_to courses_path, notice: 'Course was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  private
  def course_params
    params.require(:course).permit(:short_name, :name, :description)
  end
end

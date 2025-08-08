class CoursesController < ApplicationController
  def index
    @courses = Course.all
  end

  def new
    # Logic for new course creation can be added here
  end
end

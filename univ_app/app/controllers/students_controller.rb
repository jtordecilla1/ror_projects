class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update]
  skip_before_action :require_user, only: [:new, :create]
  def index
    @students = Student.all 
  end

  def new
    @student = Student.new
  end

  def show
    @courses = @student.courses
  end

  def create
    @student = Student.new(student_params)
    if @student.save
      redirect_to @student, notice: 'Student was successfully created.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @student.update(student_params)
      redirect_to @student, notice: 'Student was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
  def student_params
    params.require(:student).permit(:name, :email, :password, :password_confirmation)
  end

  def set_student
    @student = Student.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to students_path, alert: 'Student not found.'
  end

end

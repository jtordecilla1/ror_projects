class CategoriesController < ApplicationController
  before_action :require_admin_user, except: %i[index show]
  before_action :set_category, only: %i[show edit update]

  def new
    @category = Category.new
  end

  def index
    @categories = Category.paginate(page: params[:page], per_page: 5)
  end

  def create
    @category = Category.new(category_params)
    if @category.save
      redirect_to category_path(@category), notice: "Category was successfully created."
    else
      render :new
    end
  end

  def show
    @articles = @category.articles
  end

  def edit
  end
  
  def update
    if @category.update(category_params)
      redirect_to category_path(@category), notice: "Category was successfully updated."
    else
      render :edit
    end
  end

  private
  def category_params
    params.require(:category).permit(:name)
  end

  def set_category
    @category = Category.find(params[:id])
  end

  def require_admin_user
    unless logged_in? && current_user.admin?
      flash[:alert] = "Only admins can perform that action"
      redirect_to root_path
    end
  end
end
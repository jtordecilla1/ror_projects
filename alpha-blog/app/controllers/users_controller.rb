class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show]
  def index
    #@users = User.all
    @users = User.paginate(page: params[:page], per_page: 3)
  end

  def show
    @articles = @user.articles.paginate(page: params[:page], per_page: 3)
  end

  def new
    @user = User.new
  end

  def edit
  end

  def update
    if @user.update(user_params)
      redirect_to user_path, notice: "User information updated successfuly"
    else
      render 'edit'
    end
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username.capitalize}, you've successfully registered"
      redirect_to articles_path
    else
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def set_user
    @user = User.find(params[:id])
  end

end
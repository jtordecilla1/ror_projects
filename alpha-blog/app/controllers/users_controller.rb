class UsersController < ApplicationController
  before_action :set_user, only: %i[edit update show destroy]
  before_action :require_user, only: %i[edit update destroy]
  before_action :require_same_user, only: %i[edit update destroy]


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
      session[:user_id] = @user.id
      flash[:notice] = "Welcome to the Alpha Blog #{@user.username.capitalize}, you've successfully registered"
      redirect_to articles_path
    else
      render :new
    end
  end

  def destroy
    if @user.destroy
      flash[:notice] = "User and associated articles deleted successfully"
      redirect_to root_path
    end
  end

  private
  def set_user
    begin
      @user = User.find(params[:id])
    rescue 
      redirect_to users_path
    end
  end
  
  def user_params
    params.require(:user).permit(:username, :email, :password)
  end

  def require_same_user
    unless current_user == @user || current_user.admin?
      flash[:alert] = "You can only modify your own account"
      redirect_to users_path
    end
  end

end
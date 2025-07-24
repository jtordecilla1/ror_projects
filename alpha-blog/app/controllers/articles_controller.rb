class ArticlesController < ApplicationController
  #before_action :set_article, only: [:show, :edit, :update, :destroy]
  before_action :set_article,  only: %i[ show edit update destroy ]
  before_action :require_same_user, except: %i[index show new create]
  before_action :require_user, only: %i[new create update destroy]
  
  def index
    #@articles = Article.all
    @articles = Article.paginate(page: params[:page], per_page: 3)
  end
  
  def show
  end

  def new
    @article = Article.new
    @categories = Category.all
  end

  def edit
    @categories = Category.all
  end

  def create
    
    # We use 'require' to use just the fields that article needs!
    @article = Article.new(article_params)
    # render plain: @article.inspect
    @article.user = current_user if current_user
    @article.categories = Category.where(id: params[:article][:category_ids]) if params[:article][:category_ids].present?

    if @article.save
      flash[:notice] = "Article was created successfully."
      #redirect_to @article                # => Redirect to article index
      redirect_to article_path(@article) # => Redirect to 'show' view
    else
      render 'new'
    end
  end

  def update
    if @article.update(article_params)
      flash[:notice] = "Article was updated successfully"
      redirect_to @article
    else
      render 'edit'
    end
  end

  def destroy
    if @article.destroy
      flash[:notice] = "Article was deleted successfully"
      redirect_to articles_path  # Redirect to index, not the deleted article
    else
      flash[:alert] = "Article could not be deleted"
      redirect_to @article
    end
  end

  private

  def set_article
    begin
      @article = Article.find(params[:id])
    rescue 
      redirect_to articles_path
    end
    
  end

  def article_params
      # new_implementation => params.expect(article: [ :title, :description ])
      params.require(:article).permit(:title, :description, category_ids: [])
    end

  def require_same_user
    unless current_user && (current_user == @article.user || current_user.admin?)
      flash[:alert] = "You can only modify your own articles."
      redirect_to articles_path
    end
  end

end

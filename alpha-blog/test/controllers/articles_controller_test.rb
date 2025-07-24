require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: "user", email: "user@example.com", password: "password", admin: false)
    log_in_as(@user)
    @category1 = Category.create(name: "Technology")
    @category2 = Category.create(name: "Science")
    @categories = Category.all
    @article = Article.create(title: "Test Article", description: "This is a test article.", user: @user)
  end

  def log_in_as(user)
    post login_path, params: { session: { email: user.email, password: '123456' } }
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@user)
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    sign_in_as(@user)
    assert_difference("Article.count") do
      post articles_url, params: { article: { description: @article.description, title: @article.title, category_ids: [@category1.id, @category2.id] } }
    end

    article = Article.last
    assert_redirected_to article_url(article)
    assert_equal 2, article.categories.count
    assert_includes article.categories, @category1
    assert_includes article.categories, @category2
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article with categories" do
    sign_in_as(@user)
    patch article_url(@article), params: { article: { description: "Updated description", title: "Updated title", category_ids: [@category1.id] } }
    assert_redirected_to article_url(@article)
    @article.reload
    assert_equal "Updated description", @article.description
    assert_equal "Updated title", @article.title
    assert_equal 1, @article.categories.count
    assert_includes @article.categories, @category1
    assert_not_includes @article.categories, @category2
  end

  test "should destroy article" do
     sign_in_as(@user)
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end

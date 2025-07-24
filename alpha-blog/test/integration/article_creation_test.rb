require "test_helper"

class ArticleCreationTest < ActionDispatch::IntegrationTest
  test "can create an article" do
    user = User.create(username: "testuser", email: "testuser@example.com", password: "password")
    post login_path, params: { session: { email: user.email, password: "password" } }
    get new_article_path
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path, params: { article: { title: "Test Article", description: "This is a test article description." } }
    end
    follow_redirect!
    assert_response :success
    assert_match "Test Article", response.body
  end
end

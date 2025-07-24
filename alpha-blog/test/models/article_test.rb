require "test_helper"

class ArticleTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  # Example helper for logging in a user in tests
  def log_in_as(user)
    post login_path, params: { session: { email: user.email, password: '123456' } }
  end

  # In your test setup
  setup do
    @user = User.find_by(email: "mochi@gmail.com")
    log_in_as(@user)
  end
end

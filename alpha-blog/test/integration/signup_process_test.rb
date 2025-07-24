require "test_helper"

class SignupProcessTest < ActionDispatch::IntegrationTest
  test "can sign up a new user" do
    get signup_path
    assert_response :success
    assert_difference "User.count", 1 do
      post users_path, params: { user: { username: "newuser", email: "newuser@example.com", password: "password" } }
    end
    follow_redirect!
    assert_response :success
    assert_match "Welcome to the Alpha Blog", response.body
  end
end

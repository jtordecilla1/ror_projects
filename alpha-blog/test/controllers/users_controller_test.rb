require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  
  setup do
    @user = User.create(username: "user", email: "user@example.com", password: "password", admin: false)
  end

  # index
  test "should get index" do
    get users_url
    assert_response :success
  end
  
  test "should get new" do 
    get signup_url
    assert_response :success
  end

  # show
  test "should show user" do
    sign_in_as(@user)
    get users_url(@user)
    assert_response :success
  end
   
  # create
  test "should create user" do
    assert_difference("User.count") do
      post users_url, params: { user: { username: "newuser", email: "new@example.com", password: "password" } }
    end
  end
  
  # edit
  test "should show edit view" do
    sign_in_as(@user)
    get edit_user_url(@user)
    assert_response :success
  end

  # update
  test "should update user info" do
    sign_in_as(@user)
    patch user_url(@user), params: { user: { username: "updateduser", email: "updated@example.com", password: "newpassword" } }
    assert_redirected_to user_path(@user)
    @user.reload
    assert_equal "updateduser", @user.username
    assert_equal "updated@example.com", @user.email
  end

  test "should not update user info with invalid params" do
    sign_in_as(@user)
    patch user_url(@user), params: { user: { username: "", email: "invalid", password: "" } }
    assert_response :success
    assert_template :edit
  end

  test "shouldnt update user info if current_user != user" do
    other_user = User.create(username: "otheruser", email: "other@example.com", password: "password", admin: false)
    sign_in_as(other_user)
    patch user_url(@user), params: { user: { username: "hacker", email: "hacker@example.com", password: "hackpass" } }
    assert_redirected_to users_path
    follow_redirect!
    assert_match "You can only modify your own account", response.body
    @user.reload
    assert_not_equal "hacker", @user.username
    assert_not_equal "hacker@example.com", @user.email
  end

  # destroy
  test "should delete the user" do
    sign_in_as(@user)
    assert_difference("User.count", -1) do
      delete user_url(@user)
    end
  end
end

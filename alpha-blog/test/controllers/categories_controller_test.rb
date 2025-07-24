require "test_helper"

class CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @category = Category.create(name: "Sports")
    @admin_user = User.create(username: "admin", email: "admin@example.com", password: "password", admin: true)
  end

  test "should get index" do
    get categories_url
    assert_response :success
  end

  test "should get new" do
    sign_in_as(@admin_user)
    get new_category_url
    assert_response :success
  end

  test "should show category" do
    get category_url(@category)
    assert_response :success
  end

  test "should create category" do
    sign_in_as(@admin_user)
    assert_difference("Category.count") do
      post categories_url, params: { category: { name: "Travel" } }
    end
    assert_redirected_to category_url(Category.last)
  end

  # test "should get edit" do
  #   get edit_category_url(@category)
  #   assert_response :success
  # end

  test "should not create category if not admin" do
    assert_no_difference("Category.count") do
      post categories_url, params: { category: { name: "Travel" } }
    end
    assert_redirected_to root_path
  end
  
end

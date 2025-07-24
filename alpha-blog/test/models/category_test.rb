require 'test_helper'

class CategoryTest < ActiveSupport::TestCase
  test "category should be valid" do
    @category = Category.new(name: "Sports")
    assert @category.valid?
  end

  test "name should be present" do
    @category = Category.new(name: " ")
    assert_not @category.valid?
  end

  test "name should not be too long" do
    @category = Category.new(name: "a" * 51)
    assert_not @category.valid?
  end

  test "name should not be too short" do
    @category = Category.new(name: "aa")
    assert_not @category.valid?
  end

  test "name should be unique" do
    @category1 = Category.create(name: "Technology")
    @category2 = Category.new(name: "Technology")
    assert_not @category2.valid?
  end
end
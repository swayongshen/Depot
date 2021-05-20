require "test_helper"

class GenresControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get genres_create_url
    assert_response :success
  end

  test "should get edit" do
    get genres_edit_url
    assert_response :success
  end

  test "should get delete" do
    get genres_delete_url
    assert_response :success
  end

  test "should get show" do
    get genres_show_url
    assert_response :success
  end

  test "should get index" do
    get genres_index_url
    assert_response :success
  end
end

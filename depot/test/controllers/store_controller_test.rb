require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get store_index_url
    assert_response :success
    # Checks the 4 hyperlinks exist.
    assert_select '#columns #side a', minimum: 4
    # Checks that prices are correctly formatted.
    assert_select '.price', /\$[,\d]+\.\d\d/
    # Checks that there are 3 entries, according to test fixtures.
    assert_select '#main .entry', 3
    # Checks that the Ruby book test case is rendered.
    assert_select 'h3', 'Programming Ruby 1.9'
  end
end

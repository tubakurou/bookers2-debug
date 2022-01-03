require 'test_helper'

class DefControllerTest < ActionDispatch::IntegrationTest
  test "should get search" do
    get def_search_url
    assert_response :success
  end

end

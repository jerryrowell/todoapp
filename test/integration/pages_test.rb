require 'test_helper'

class PagesTest < ActionDispatch::IntegrationTest
  
  test "should get home" do
    get todos_url
    assert_response :success
  end
  
  test "should get root" do
    get root_url
    assert_response :success
  end
end

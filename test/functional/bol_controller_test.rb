require 'test_helper'

class BolControllerTest < ActionController::TestCase
  test "should get suggestions" do
    get :suggestions
    assert_response :success
  end

end

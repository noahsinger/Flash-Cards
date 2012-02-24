require 'test_helper'

class HomeControllerTest < ActionController::TestCase

  test "should get index" do
    get :index
    assert_response :success
  end
  
  test "should recognize valid user" do
    get :valid_user, :email => users(:one), :format => "js"
    assert_response :success
  end

end

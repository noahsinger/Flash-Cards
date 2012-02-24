require 'test_helper'

class RegistrationControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create/register user" do
    assert_difference('ActionMailer::Base.deliveries.size') do
      assert_difference('User.count') do
        post :create, email: "user3@test.com", password: "secret"
      end
    end

    assert_redirected_to root_url
  end
  
  test "should register a user with a valid reg code" do
    get :confirmation, id: users(:one).reg_hash
    assert_equal true, assigns(:user).registered
    assert_redirected_to new_session_path
  end
  
  test "should not register a user with an invalid code" do
    get :confirmation, id: '7618746328746534785634782'
    assert_redirected_to root_path
  end
end












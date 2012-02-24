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
end

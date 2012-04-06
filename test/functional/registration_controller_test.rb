require 'test_helper'

class RegistrationControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create/register user" do
    assert_difference('ActionMailer::Base.deliveries.size') do
      assert_difference('User.count') do
        post :create, email: "new_user@test.com", password: "secret", password_confirmation: "secret"
      end
    end

    assert_redirected_to root_url
  end
  
  test "should not create user without password confirmation" do
    assert_no_difference('ActionMailer::Base.deliveries.size') do
      assert_no_difference('User.count') do
        post :create, email: "user3@test.com", password: "secret", password_confirmation: "wrong"
      end
    end
  end
  
  test "should register a user with a valid reg code" do
    get :confirmation, id: users(:one).reg_hash
    assert_equal true, assigns(:user).registered
    assert_redirected_to decks_path
  end
  
  test "should not register a user with an invalid code" do
    get :confirmation, id: '7618746328746534785634782'
    assert_redirected_to root_path
  end
  
  test "should get edit page" do
    login( users(:one) )
    get :edit, id: users(:one).id
    assert_response :success
  end
  
  test "should not be able to edit a different user" do
    login(users(:one))
    get :edit, id: users(:two).id
    assert_redirected_to root_path
  end
  
  test "should update users email address" do
    login(users(:one))

    assert_difference('ActionMailer::Base.deliveries.size') do
      put :update, id: users(:one).id, email: "updated_user@test.com"
    end
    
    assert_equal "updated_user@test.com", assigns(:user).email
    assert_redirected_to decks_path
  end
  
  test "should update users password" do
    login(users(:one))
    put :update, id: users(:one).id, email: users(:one).email, password: "newpass", password_confirmation: "newpass"
    
    assert_redirected_to decks_path
  end
end












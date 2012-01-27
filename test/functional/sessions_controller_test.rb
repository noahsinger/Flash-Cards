require 'test_helper'

class SessionsControllerTest < ActionController::TestCase

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should create new session (login) with valid user" do
    user = User.create( email: "test@test.com", password: "secret" )
    post :create, email: "test@test.com", password: "secret"
    
    assert_equal user.id, session[:user]
    assert_redirected_to root_path
  end
  
  test "should not create new session (login) with invalid user" do
    user = User.create( email: "test@test.com", password: "secret" )
    post :create, email: "test@test.com", password: "badsecret"
    
    assert_equal nil, session[:user]
    assert_redirected_to new_session_path
  end
  
  test "should destroy session (logout)" do
    delete :destroy
    assert_equal nil, session[:user]
    assert_redirected_to root_path
  end

end










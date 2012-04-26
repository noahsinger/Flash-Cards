require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    @user = users(:one)
    login( users(:admin) )
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:users)
  end
  
  test "index should only be accessible to admin users" do
    logout( )
    login( users(:one) )
    get :index
    assert_redirected_to decks_path
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, user: {email: "new_user@test.com", password: "secret"}
    end

    assert_redirected_to user_path(assigns(:user))
  end

  test "should show user" do
    get :show, id: @user
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    put :update, id: @user, user: {email: @user.email, password: @user.password}
    assert_redirected_to user_path(assigns(:user))
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end

    assert_redirected_to users_path
  end
end

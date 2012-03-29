require 'test_helper'

class DecksControllerTest < ActionController::TestCase
  setup do
    @deck = decks(:one)
    login( users(:one) )
  end

  test "should get index if loggedin" do
    session[:user_id] = users(:one)
    
    get :index
    assert_response :success
    assert_not_nil assigns(:decks)
  end
    
  test "should not get index if not logged in" do
    logout( )
    get :index
    assert_redirected_to root_path
  end

  test "should get new" do
    get :new
    assert_response :success
  end
  
  test "should get reorder" do
    get :reorder, deck_id: decks(:one).id
    assert_response :success
    
    assert_not_nil assigns(:deck)
  end
  
  test "should get shuffle" do
    get :shuffle, deck_id: decks(:one).id
    assert_not_nil assigns(:deck)
  end

  test "should create deck" do
    session[:user_id] = users(:one).id
    
    assert_difference('Deck.count') do
      post :create, deck: {name: "test deck"}
    end

    assert_not_nil assigns(:deck).user_id
    assert_equal session[:user_id], assigns(:deck).user_id
    assert_redirected_to deck_cards_path(assigns(:deck))
  end

  test "should get edit" do
    get :edit, id: @deck
    assert_response :success
  end

  test "should update deck" do
    put :update, id: @deck, deck: {name: 'updated name'}
    assert_redirected_to deck_cards_path(assigns(:deck))
  end
  
  test "should not be able to update other users decks" do
    put :update, id: decks(:two), deck: {name: 'new name'}
    assert_redirected_to root_path
  end

  test "should destroy deck" do
    assert_difference('Deck.count', -1) do
      delete :destroy, id: @deck
    end

    assert_redirected_to decks_path
  end
  
  test "shouod not destroy other users decks" do
    assert_no_difference('Deck.count') do
      delete :destroy, id: decks(:two)
    end
    
    assert_redirected_to root_path
  end
end











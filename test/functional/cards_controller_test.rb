require 'test_helper'

class CardsControllerTest < ActionController::TestCase
  setup do
    @card = cards(:one)
    login( users(:one) )
  end

  test "should get index" do
    get :index, :deck_id => decks(:one)
    assert_response :success
    assert_not_nil assigns(:cards)
  end

  test "should get new" do
    get :new, :deck_id => decks(:one)
    assert_response :success
  end
  
  test "should not be able to access other users cards" do
    get :index, :deck_id => decks(:two)
    assert_redirected_to root_url
  end

  test "should create card" do
    assert_difference('Card.count') do
      post :create, card: {content: 'new card'}, :deck_id => decks(:one)
    end

    assert_redirected_to new_deck_card_path(assigns(:deck))
  end

  test "should show card" do
    get :show, id: @card, :deck_id => decks(:one)
    assert_response :success
  end
  
  test "should not show card if not logged in" do
    logout
    get :show, id: @card, :deck_id => decks(:one)
    assert_redirected_to root_path
  end

  test "should get edit" do
    get :edit, id: @card, :deck_id => decks(:one)
    assert_response :success
  end
  
  test "should get move up" do
    get :move_up, deck_id: decks(:one), card_id: cards(:three)
    assert_not_nil assigns(:card)
    assert_redirected_to deck_reorder_path(decks(:one))
  end
  
  test "should get move down" do
    get :move_down, deck_id: decks(:one), card_id: cards(:three)
    assert_not_nil assigns(:card)
    assert_redirected_to deck_reorder_path(decks(:one))
  end

  test "should update card" do
    put :update, id: @card, card: {content: 'new card'}, :deck_id => decks(:one)
    assert_redirected_to deck_card_path(assigns(:deck), assigns(:card))
  end

  test "should destroy card" do
    assert_difference('Card.count', -1) do
      delete :destroy, id: @card, :deck_id => decks(:one)
    end

    assert_redirected_to deck_cards_path(assigns(:deck))
  end
end

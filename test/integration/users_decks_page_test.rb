require 'test_helper'

class UsersDecksPageTest < ActionDispatch::IntegrationTest
  setup do
    # post sessions_path, email: users(:one).email, password: "secret"
    capybara_login  
  end
  
  test "users can see their decks" do
    visit decks_path
    # save_and_open_page
    
    wait_until { assert page.has_content?( "Empty Deck" ), "Page should have an \"Empty Deck\"" }
    wait_until { assert page.has_content?( "MyString" ), "Page should have a deck called \"MyString\"" }
    
    assert_equal decks_path, current_path
  end
  
  test "users can make new decks" do
    visit decks_path
    click_link "New Deck"
    assert_equal new_deck_path, current_path
    fill_in 'deck_name', with: "I'm a New Deck"
    click_button 'Create Deck'
    # save_and_open_page
    # redirect to deck_cards_path happends here
    wait_until { assert page.has_content?( "I'm a New Deck" ), "New deck isn't present on decks page after it was created" }
  end
  
  teardown do
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    DatabaseCleaner.clean
  end
end

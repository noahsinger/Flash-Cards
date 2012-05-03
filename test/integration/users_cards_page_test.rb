require 'test_helper'

class UsersCardsPageTest < ActionDispatch::IntegrationTest
  setup do
    # post sessions_path, email: users(:one).email, password: "secret"
    capybara_login
  end
  
  test "users can see their cards" do
    visit deck_cards_path(decks(:one))
    # save_and_open_page
    wait_until {assert page.has_content?( "something" ), "Card that says \"something\" is not shown"}
    wait_until {assert page.has_content?( "words" ), "Card that says \"words\" is not shown"}
    
    assert_equal deck_cards_path(decks(:one)), current_path
  end
  
  test "users can add new cards" do
    visit deck_cards_path(decks(:one))
    click_link 'Add a New Card'
    wait_until { assert page.has_selector?( "form input[id=card_content]" ), "Card content field is missing from new card form" }
    fill_in 'card_content', with: 'New Card 1'
    click_button '+'
    wait_until { assert page.has_content?( "New Card 1" ), "New card did not appear on new card page when added" }
  end
  
  teardown do
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    DatabaseCleaner.clean
  end
end

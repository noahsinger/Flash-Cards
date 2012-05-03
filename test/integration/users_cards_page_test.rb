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
  
  test "users can use the logout link" do
    visit deck_cards_path(decks(:one))
    # save_and_open_page
    
    wait_until { assert page.has_content?( "Logout" ), "Logout link is missing from page"}
    click_link "Logout"
    assert_equal root_path, current_path
  end
  
  teardown do
    Capybara.reset_sessions!    # Forget the (simulated) browser state
  end
end

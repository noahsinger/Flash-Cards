require 'test_helper'

class UsersCardsPageTest < ActionDispatch::IntegrationTest
  setup do
    post sessions_path, email: users(:one).email, password: "secret"
  end
  
  test "users can see their cards" do
    visit deck_cards_path(decks(:one))
    # save_and_open_page
    assert_equal deck_cards_path(decks(:one)), current_path
    wait_until { page.has_content? "something" }
    wait_until { page.has_content? "words" }
  end
end

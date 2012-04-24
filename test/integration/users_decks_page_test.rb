require 'test_helper'

class UsersDecksPageTest < ActionDispatch::IntegrationTest
  setup do
    post sessions_path, email: users(:one).email, password: "secret"
  end
  
  test "users can see their decks" do
    visit decks_path
    # save_and_open_page
    assert_equal decks_path, current_path
    wait_until { page.has_content? "Empty Deck" }
    wait_until { page.has_content? "MyString" }
  end
end

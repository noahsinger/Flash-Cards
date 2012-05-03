require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "users can login" do
    capybara_login
    wait_until { assert page.has_content?( "Your Decks" ), "\"Your Decks\" header is missing from page" }
  end
  
  test "users can use the logout link" do
    capybara_login
    visit deck_cards_path(decks(:one))
    # save_and_open_page
    
    wait_until { assert page.has_content?( "Logout" ), "Logout link is missing from page"}
    click_link "Logout"
    assert_equal root_path, current_path
  end
  
  test "user with unknown email is offered registration" do
    visit root_path
    fill_in 'email', with: 'unknown@unknown.com'
    wait_until { assert page.has_content?( "Password" ), "\"Password\" is missing from page" }
    wait_until { assert page.has_content?( "Password confirmation" ), "\"Password confirmation\" is missing from page" }
    wait_until { assert page.has_selector?( "form input[value=Register]" ), "Register button is missing from form" }
  end
  
  test "failed login given another attempt" do
    visit root_path
    fill_in 'email', with: users(:one).email
    wait_until { assert page.has_content?( "Password" ), "\"Password\" is missing from page" }
    fill_in 'password', with: 'wrong_secret'
    wait_until { assert page.has_selector?( "form input[value=Login]" ), "Login button is missing from form after failed login" }
    click_button 'Login'
    # save_and_open_page
    assert_equal root_path, current_path
  end
  
  teardown do
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    DatabaseCleaner.clean
  end
end

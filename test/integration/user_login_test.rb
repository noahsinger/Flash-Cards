require 'test_helper'

class UserLoginTest < ActionDispatch::IntegrationTest
  test "users can login" do
    visit root_path
    fill_in 'email', with: users(:one).email
    wait_until { page.has_content? "Password" }
    fill_in 'password', with: 'secret'
    wait_until { page.has_selector? "form input[value=Login]" }
    click_button 'Login'
    # save_and_open_page
    # assert_equal decks_path, current_path
    wait_until { page.has_content? "Your Decks" }
  end
  
  test "user with unknown email is offered registration" do
    visit root_path
    fill_in 'email', with: 'unknown@unknown.com'
    wait_until { page.has_content? "Password" }
    wait_until { page.has_content? "Password confirmation" }
    wait_until { page.has_selector? "form input[value=Register]" }
  end
  
  test "failed login given another attempt" do
    visit root_path
    fill_in 'email', with: users(:one).email
    wait_until { page.has_content? "Password" }
    fill_in 'password', with: 'wrong_secret'
    wait_until { page.has_selector? "form input[value=Login]" }
    click_button 'Login'
    # save_and_open_page
    assert_equal root_path, current_path
  end
end

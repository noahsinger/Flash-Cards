require 'test_helper'

class RegistrationTest < ActionDispatch::IntegrationTest
  test "users can register" do
    visit root_path
    fill_in 'email', with: "newuser@user.com"
    wait_until { page.has_content? "Password" }
    fill_in 'password', with: 'secret'
    wait_until { page.has_content? "Password confirmation" }
    fill_in 'password_confirmation', with: 'secret'
    wait_until { page.has_selector? "form input[value=Register]" }
    click_button 'Register'
    # save_and_open_page
    assert_equal root_path, current_path
  end
  
  test "failed registration gives another attempt" do
    visit root_path
    fill_in 'email', with: "newuser@user.com"
    wait_until { page.has_content? "Password" }
    fill_in 'password', with: 'secret'
    wait_until { page.has_content? "Password confirmation" }
    fill_in 'password_confirmation', with: 'blah'
    wait_until { page.has_selector? "form input[value=Register]" }
    click_button 'Register'
    # save_and_open_page
    assert_equal root_path, current_path
  end
end

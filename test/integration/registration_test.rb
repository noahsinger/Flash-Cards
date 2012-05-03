require 'test_helper'

class RegistrationTest < ActionDispatch::IntegrationTest
  test "users can register" do
    visit root_path
    fill_in 'email', with: "newuser@user.com"
    wait_until { assert page.has_content?( "Password" ), "\"Password\" is missing from page" }
    fill_in 'password', with: 'secret'
    wait_until { assert page.has_content?( "Password confirmation" ), "\"Password confirmation\" is missing from page" }
    fill_in 'password_confirmation', with: 'secret'
    wait_until { assert page.has_selector?( "form input[value=Register]" ), "Register button is missing from page" }
    click_button 'Register'
    # save_and_open_page
    assert_equal root_path, current_path
  end
  
  test "failed registration gives another attempt" do
    visit root_path
    fill_in 'email', with: "newuser@user.com"
    wait_until { assert page.has_content?( "Password" ), "\"Password\" is missing from page" }
    fill_in 'password', with: 'secret'
    wait_until { assert page.has_content?( "Password confirmation" ), "\"Password confirmation\" is missing from page"}
    fill_in 'password_confirmation', with: 'blah'
    wait_until { assert page.has_selector?( "form input[value=Register]" ), "Register button is missing from page" }
    click_button 'Register'
    # save_and_open_page
    assert_equal root_path, current_path
  end
  
  teardown do
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    DatabaseCleaner.clean
  end
end

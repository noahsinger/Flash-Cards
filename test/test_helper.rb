ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  class ActionDispatch::IntegrationTest
    include Capybara::DSL
  end
  
  # clean out and rebuild the database after each test, slow but better for the integration tests
  require 'database_cleaner'
  DatabaseCleaner.strategy = :truncation
  
  Capybara.javascript_driver = :webkit
  Capybara.default_wait_time = 15
  
  Capybara.current_driver = Capybara.javascript_driver # without this you will not being using javascript
  
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all
  
  class ActiveRecord::Base
    mattr_accessor :shared_connection
    @@shared_connection = nil

    def self.connection
      @@shared_connection || retrieve_connection
    end
  end
  ActiveRecord::Base.shared_connection = ActiveRecord::Base.connection
  
  # Add more helper methods to be used by all tests here...
  
  def login( user )
    session[:user_id] = user ? user.id : nil
  end
  
  def capybara_login
    visit root_path
    fill_in 'email', with: users(:one).email
    wait_until { assert page.has_content?( "Password" ), "Login procedure failed: \"Password\" is missing from page" }
    fill_in 'password', with: 'secret'
    wait_until { assert page.has_selector?( "form input[value=Login]" ), "Login procedure failed: Login button is missing from form when logging in correctly" }
    click_button 'Login'
    wait_until { assert page.has_content?( "Your Decks" ), "Login procedure failed: \"Your Decks\" header is missing from page" }
  end
  
  def logout
    session[:user_id] = nil
  end
end

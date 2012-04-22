ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'

class ActiveSupport::TestCase
  class ActionDispatch::IntegrationTest
    include Capybara::DSL
  end

  Capybara.javascript_driver = :webkit
  Capybara.current_driver = :webkit #without this you will not being using javascript in webkit
  
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  def login( user )
    session[:user_id] = user ? user.id : nil
  end
  
  def logout
    session[:user_id] = nil
  end
  
  # Add more helper methods to be used by all tests here...
end

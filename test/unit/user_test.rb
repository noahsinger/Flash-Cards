require 'test_helper'

class UserTest < ActiveSupport::TestCase
  
  test "should allow valid email addresses" do
    user1 = User.create( :email => "noah@test.com", :password => "secret" )
    assert_equal 3, User.count
  end
  
end

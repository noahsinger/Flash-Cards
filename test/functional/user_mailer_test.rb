require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test "registration" do
    mail = UserMailer.registration(  users(:one) )
    assert_equal "Registration Confirmation", mail.subject
    assert_equal [users(:one).email], mail.to
    # assert_equal ["from@example.com"], mail.from
    # assert_match "#{users(:one).reg_hash}", mail.body.encoded
  end

end

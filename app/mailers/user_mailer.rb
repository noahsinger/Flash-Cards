class UserMailer < ActionMailer::Base
  default from: "no-reply@littlewhitecards.com"

  def registration( user )
    @user = user
    @user.update_attribute( :emailed_at, Time.now )
    mail to: @user.email, subject: "Registration Confirmation"
  end
end

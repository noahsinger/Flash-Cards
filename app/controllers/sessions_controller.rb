class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      if user.registered
        session[:user_id] = user.id
        redirect_to decks_path, :notice => "You are logged in"
      else
        if (Time.now - 5.minutes) > user.emailed_at
          UserMailer.registration( user ).deliver
        end
        
        redirect_to new_session_path, :alert => "You must verify your email account before you can login"
      end
    else
      redirect_to new_session_path, :alert => "Bad username or password"
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_path, :notice => "You are logged out"
  end
end

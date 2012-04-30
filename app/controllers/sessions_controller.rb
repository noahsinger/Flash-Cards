class SessionsController < ApplicationController
  def new
  end
  
  def create
    @user = User.find_by_email(params[:email])
    respond_to do |format|
      if @user && @user.authenticate(params[:password])
        if @user.registered
          session[:user_id] = @user.id
          format.html {redirect_to decks_url, :notice => "You are logged in"}
          @status = "registered"
          format.js
        else
          if (Time.now - 5.minutes) > @user.emailed_at
            UserMailer.registration( @user ).deliver
          end
        
          flash.now.alert = "You must verify your email account before logging in"
          format.html {redirect_to root_url}
          @status = "unregistered"
          format.js
        end
      else
        format.html {redirect_to root_url, :alert => "Bad username or password"}
        @status = "notfound"
        flash.now.alert = "Unknown username or password"
        format.js
      end
    end
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "You are logged out"
  end
end

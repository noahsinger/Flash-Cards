class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.find_by_email(params[:email])
    if user && user.authenticate(params[:password])
      session[:user] = user.id
      redirect_to root_path, :notice => "You are logged in"
    else
      redirect_to new_session_path, :alert => "Bad username or password"
    end
  end
  
  def destroy
    session[:user] = nil
    redirect_to root_path, :notice => "You are logged out"
  end
end

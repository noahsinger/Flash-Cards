class HomeController < ApplicationController
  def index
    @user = User.new
  end
  
  def valid_user
    @user = User.find_by_email( params[:email] )
    respond_to do |format|
      format.js #valid_user.js.erb
    end
  end
end

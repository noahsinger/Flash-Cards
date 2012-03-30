class RegistrationController < ApplicationController
  
  before_filter :authenticate, :only => [:edit, :update]
  before_filter :authorize, :only => [:edit, :update]
  
  def authorize
    @user = User.find params[:id]
    unless current_user == @user
      redirect_to root_url, notice: "You are not authorized to access that"
    end
  end
    
	def	new
	end

  def create
    @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

    respond_to do |format|
      if @user.save
      	UserMailer.registration( @user ).deliver
        format.html { redirect_to root_url, notice: 'Check your Email!  We just sent you a link to verify your email address.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        flash.now.alert = "Your password and confirmation did not match"
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def confirmation
    @user = User.find_by_reg_hash(params[:id])
    if @user
      @user.update_attribute( :registered, true )
      session[:user_id] = @user.id
      redirect_to decks_path, notice: "You are now registered and logged in. Make cards and prosper!"
    else
      redirect_to root_path, notice: "Invalid Registration Code"
    end
  end
  
  def edit
    @user = User.find params[:id]
  end
  
  def update
    @user = User.find params[:id]    
    @user.email = params[:email] if params[:email] and not params[:email].blank?
    @user.password = params[:password] if params[:password] and not params[:password].blank?

    email_changed = @user.email_changed?

    respond_to do |format|
      if @user.save
        
        msg = ""
        if email_changed
          UserMailer.registration( @user ).deliver
          msg = "An email has been sent to your new address, please confirm by clicking the link in that email"
        end
        
        format.html { redirect_to decks_url, notice: "Your profile has been updated. #{msg}" }
        format.json { render json: @user, status: :created, location: @user }
      else
        flash.now.alert = "There was a problem"
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end












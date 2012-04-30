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
	  @user = User.new
	end

  def create
    @user = User.new(email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation])

    respond_to do |format|
      if @user.save
      	UserMailer.registration( @user ).deliver
      	flash.now.notice = 'Check your Email!  We just sent you a link to verify your email address.'
        format.html { redirect_to root_url }
        format.json { render json: @user, status: :created, location: @user }
        logger.info "***************Rendering create after save*******************"
        format.js
      else
        flash.now.alert = @user.errors.full_messages.delete_if {|msg| msg.index(/digest/)}.join( ', ' )
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
        logger.info "***************Rendering create after fail*******************"
        format.js
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
    old_email = @user.email

    respond_to do |format|
      if @user.update_attributes( {email: params[:email], password: params[:password], password_confirmation: params[:password_confirmation]} )
        
        msg = ""
        unless old_email == @user.email
          UserMailer.registration( @user ).deliver
          msg = "An email has been sent to your new address, please confirm by clicking the link in that email"
        end
        
        format.html { redirect_to decks_url, notice: "Your profile has been updated. #{msg}" }
        format.json { render json: @user, status: :created, location: @user }
      else
        flash.now.alert = "There was a problem saving your changes"
        format.html { render action: "edit" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
end












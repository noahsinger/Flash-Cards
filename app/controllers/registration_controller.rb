class RegistrationController < ApplicationController
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
end












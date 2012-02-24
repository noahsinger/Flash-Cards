class RegistrationController < ApplicationController
	def	new
	end

  def create
    @user = User.new(email: params[:email], password: params[:password])

    respond_to do |format|
      if @user.save
      	UserMailer.registration( @user ).deliver
        format.html { redirect_to root_url, notice: 'You have been registered.' }
        format.json { render json: @user, status: :created, location: @user }
      else
        format.html { render action: "new" }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def confirmation
    @user = User.find_by_reg_hash(params[:id])
    if @user
      @user.update_attribute( :registered, true )
      redirect_to new_session_path, notice: "You are now registered and can login"
    else
      redirect_to root_path, notice: "Invalid Registration Code"
    end
  end
end












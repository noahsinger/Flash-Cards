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
end

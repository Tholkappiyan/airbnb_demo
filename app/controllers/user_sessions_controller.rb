class UserSessionsController < ApplicationController

	before_filter :require_user, :only => :destroy

	def new
		@user_session = UserSession.new
	end

	def create
		@user_session = UserSession.new(params[:user_session])
		if @user_session.save
			flash.now[:sucess] = "Login Sucessful!"
			#current_user_session.user = User.find_by_email(params[:session][:email].downcase)
			redirect_to current_user
		else
			render 'new'
		end
	end

	def destroy
		current_user_session.destroy
		flash.now[:sucess] = "Logout Sucessful"
		redirect_back_or_default root_path
	end

end

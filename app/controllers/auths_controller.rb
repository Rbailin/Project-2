class AuthsController < ApplicationController

	 def new 
	 	if current_user
	 		redirect_to users_path
	 	else
	 		@user = User.new
		end
	end

	def create 
		user = User.find_by(username: params[:user][:username])
		if user && user.authenticated?(params[:user][:password])
			session[:user_id] = user.id
			redirect_to users_path
		else
			flash[:notice] = "You are not logged in! I bet you're sad."
			redirect_to new_auth_path
		end
	end


	def destroy
		session[:user_id] = nil
		redirect_to root_path
	end
end


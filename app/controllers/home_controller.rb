class HomeController < ApplicationController
	def index
		@user = User.new
	end
	
	def login
		@user = User.find_by_email(params[:email])
		if(@user && @user.password == params[:password])
			session[:user_id] = @user.id
			redirect_to timeblocks_show_path
		else
			flash[:notice] = "Wrong user name or password!"
			redirect_to :action => "index"
		end
	end
end

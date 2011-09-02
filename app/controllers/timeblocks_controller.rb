class TimeblocksController < ApplicationController
	def show
		@user = session[:user]
		
	end
end

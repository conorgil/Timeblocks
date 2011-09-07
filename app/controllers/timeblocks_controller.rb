class TimeblocksController < ApplicationController
  def show
	  @user = session[:user]
	  @timeblocks = Timeblock.find_all_by_user_id(@user.id)
	  @date = Date.today
  end
	
	def update
	end
	
	def new
		@timeblock = Timeblock.new
		render :partial => "form"
	end
end

class TimeblocksController < ApplicationController
  def show
	  @user = session[:user]
	  @timeblocks = Timeblock.find_all_by_user_id(@user.id)
  end
	
	def update
	end
end

class TimeblocksController < ApplicationController
  def show
	  @user = session[:user] || User.new
 	  @date = Date.today
	  @timeblocks = Timeblock.where("user_id = :user_id AND DATE(start) = :date",
																	{:user_id => @user.id, :date => @date})
  end
	
	def update
		redirect_to timeblocks_path
	end
	
	def new
		@timeblock = Timeblock.new	
		respond_to do |format|
			format.html {render @timeblock, :layout => false}
		end		
	end
end

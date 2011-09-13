class TimeblocksController < ApplicationController
  def show
	  @user = session[:user]
 	  @date = Date.today
	  @timeblocks = Timeblock.where("user_id = :user_id AND DATE(start) = :date",
																	{:user_id => @user.id, :date => @date})
  end
	
	def update
		@timeblock = Timeblock.find_by_id(id)
		@timeblock.update_attributes(params[:id])
		respond_to do |format|
			format.html {render @timeblock, :layout => false}
		end
	end
	
	def new
		@timeblock = Timeblock.new
		respond_to do |format|
			format.html {render @timeblock, :layout => false}
		end
	end
	
	def create
	  @timeblock.create(params[:id])
	  respond_to do |format|
			format.html {render @timeblock, :layout => false}
		end
	end
end

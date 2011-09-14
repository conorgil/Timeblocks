class TimeblocksController < ApplicationController
  def show
	  @user = User.find(session[:user_id])
 	  @date = Date.today
	  @timeblocks = Timeblock.where("user_id = :user_id AND DATE(start) = :date",
																	{:user_id => @user.id, :date => @date})
  end
	
	def update
		@timeblock = Timeblock.find_by_id(params[:id])
		
		respond_to do |format|
			if @timeblock.update_attributes(params[:timeblock])
				format.html {render @timeblock, :layout => false, :locals => {:action=>"update"} }
			else
				format.html {render @timeblock, :layout => false, :locals => {:action=>"update"} }
			end
		end
	end
	
	def new
		@timeblock = Timeblock.new
		respond_to do |format|
			format.html {render @timeblock, :layout => false, :locals => {:action=>"create"} }
		end
	end
	
	def create
		@user = User.find(session[:user_id])
		@timeblock = Timeblock.new
		@timeblock.start = params[:timeblock][:start]
		@timeblock.end = params[:timeblock][:end]

    respond_to do |format|
      if @timeblock.save && @user.timeblocks << @timeblock
        format.html {render @timeblock, :layout => false, :locals => {:action=>"update"} }
      else
        format.html {render @timeblock, :layout => false, :locals => {:action=>"create"} }
      end
    end
	end
end

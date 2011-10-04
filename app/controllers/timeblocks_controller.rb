
class TimeblocksController < ApplicationController  
  def show
	  @user = User.find(session[:user_id])
 	  @date = Date.parse(params[:date]) || Date.today
	  @timeblocks = Timeblock.find_by_user_id_and_similar_date(@user.id, @date)
	  #@dailyMetricRows = DailyMetricRow.getDailyMetricRowsFromTimeblocks(@timeblocks)
  end
  
  def all
	  @user = User.find(session[:user_id])
	  @timeblocks = Timeblock.find_all_by_user_id(@user.id)
  end
	
	def update
		@timeblock = Timeblock.find_by_id(params[:id])
		
		respond_to do |format|
			if @timeblock.update_attributes(params[:timeblock])
				format.html {render @timeblock, :layout => false }
			else
				format.html {render @timeblock, :layout => false }
			end
		end
	end
	
	def new
		@timeblock = Timeblock.new
		respond_to do |format|
			format.html {render @timeblock, :layout => false }
		end
	end
	
	def create
		@user = User.find(session[:user_id])
		@timeblock = Timeblock.new
		@timeblock.user_id = @user.id
		@timeblock.tag_string = params[:timeblock][:tag_string]
		@timeblock.start = params[:timeblock][:start]
		@timeblock.end = params[:timeblock][:end]
		@timeblock.note = params[:timeblock][:note]

		respond_to do |format|
		  if @timeblock.save && @user.timeblocks << @timeblock
		    format.html {render @timeblock, :layout => false }
		  else
		    format.html {render @timeblock, :layout => false }
		  end
		end
	end
	
	def destroy
    @timeblock = Timeblock.find(params[:id])
    @timeblock.destroy
    respond_to do |format|
        format.html {render :nothing => true }
    end
  end
	
	def daily_metrics
		@user = User.find(session[:user_id])
		@timeblocks = Timeblock.find_by_user_id_and_similar_date(@user.id, @date)
		#@dailyMetricRows = DailyMetricRow.getDailyMetricRowsFromTimeblocks(@timeblocks)
	end
end

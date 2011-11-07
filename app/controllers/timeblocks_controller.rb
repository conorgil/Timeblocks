
class TimeblocksController < ApplicationController
  before_filter :date_time_format

  def show
	  @user = User.find(session[:user_id])
 	  if(params[:date].nil?)
 	    @date = Date.today
 	  else
 	    @date = Date.parse(params[:date])
 	  end
	  @timeblocks = Timeblock.find_by_user_id_and_similar_date(@user.id, @date)
	  #@dailyMetricRows = DailyMetricRow.getDailyMetricRowsFromTimeblocks(@timeblocks)
  end
  
  def all
	  @user = User.find(session[:user_id])
	  @timeblocks = Timeblock.find_all_by_user_id(@user.id)
  end
	
	def history
		@user = User.find(session[:user_id])
		@date = Date.today
		
		if(params[:start].nil?)
 	    @start_date = Date.today
 	  else
 	    @start_date = Date.parse(params[:start], @date_time_format)
 	  end
		
		if(params[:end].nil?)
 	    @end_date = Date.today
 	  else
 	    @end_date = Date.strptime(params[:end], @date_time_format)
 	  end
		
		if(@start_date > @end_date)
			@start_date = @end_date
		end
		
		@timeblocks = Timeblock.find_all_by_user_id_and_date_range(@user.id, @start_date, @end_date)
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
	
	private
	
	def date_time_format
	  @date_time_format = "%m/%d/%Y"
	end
end

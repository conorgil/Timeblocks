class TagsController < ApplicationController
  # GET /temps
  # GET /temps.xml
  def index
    @tags = Tag.find_all_by_user_id(session[:user_id])
    
    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tags }
    end
  end

end

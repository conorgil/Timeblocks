class UsersController < ApplicationController
	def new
		@user = User.new
		
		respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
	end
	
	def create
		@user = User.new(params[:user])
		
		respond_to do |format|
			if @user.save
<<<<<<< HEAD
=======
				session[:user] = @user
>>>>>>> 6d55a41567b9b7aaaa10ff1311358f738a3d0330
				flash[:notice] = "User succesfully created"
				format.html { redirect_to timeblocks_path }
				format.xml  { render :xml => @user, :status => :created, :location => @user }			
			else
				format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
			end
		end
	end
	
	def login
		@user = User.find_by_email(params[:email])
		respond_to do |format|
			if @user && @user.password == params[:password]
				session[:user] = @user
				format.html { redirect_to timeblocks_path }
			else
				format.html { render :action => "new" }
			end
		end		
	end
end

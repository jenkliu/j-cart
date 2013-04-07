class UsersController < ApplicationController
	# GET /register
	# user registration form
	def new
		@user = User.new
	end

	# POST /users
	# requires: :user param is defined
	# modifies: users (if validation passes), cookies
	# effects: 
	# => new user is created (if validation passes)
	# => user id is stored in cookies
	def create
		@user = User.new(params[:user])
		
		respond_to do |format|
			if @user.save
				cookies[:user_id] = @user.id
				# TODO: redirect to last page they were on
				format.html { redirect_to root_url }
				format.json { render json: @user, status: :created, location: @user}
			else # save fails due to validation error -> shows errors
				format.html { render action: "new" }
	        	format.json { render json: @user.errors, status: :unprocessable_entity }
			end
		end
	end
end

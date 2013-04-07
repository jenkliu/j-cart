class SessionsController < ApplicationController
	# GET /login
	# login form for user
	def new
	end

	# POST /sessions
	# attempts to authenticate user, logs in if successful
	# requires: params :email and :password
	# modifies: cookies (if authentication successful)
	# effects: stores user id in cookies
	def create
		user = User.find_by_email(params[:email])
		if user && user.authenticate(params[:password])
			cookies[:user_id] = user.id
			if user.type == "Admin"
		      redirect_to admin_orders_url
		    else
		      # TODO: redirect to last page user was on
			  redirect_to root_url
			end
		else # user authentication failed
			flash.now[:error] = "Invalid email or password. Please try again."
			render "new"
		end
	end

	# DELETE /sessions
	# logs user out and redirects to home page
	# requires: user is logged in
	# modifies: cookies
	# effects: deletes cookies, resetting session
	def destroy
		cookies.delete :user_id
		cookies.delete :cart_id
		flash.now[:notice] = "You have logged out. Thanks for visiting J-Cart!"
		redirect_to root_url
	end
end

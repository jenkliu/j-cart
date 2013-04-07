class CartsController < ApplicationController
	include CartsHelper
	before_filter :require_user_login, :only => [:view_saved, :save, :activate, :checkout, :review]
	before_filter :verify_ownership, :only => [:save, :activate, :checkout, :review]
	

	# GET /carts/current
	# display items in current cart
	def view_current
		if @current_cart
			@items = Cart.find(cookies[:cart_id]).items
			display_price_changes(@current_cart.id)
		else
			flash.now[:notice] = "You have 0 items in your cart. Start shopping!"
		end
	end

	# GET /carts/saved
	# show all saved carts
	# requires: user is logged in
	def view_saved
		@carts = Cart.where(:user_id => @current_user.id, :status => 'saved')
		if @carts.empty?
			flash.now[:notice] = "You do not have any saved carts."
		end
	end

	# GET /carts/1/save
	# requires: user is logged in, @cart belongs to user,
	# 			@cart.status = "current", @cart is not empty
	# modifies: @cart
	# effects: @cart.status = "saved"
	def save
		@cart = Cart.find(params[:id])
		@cart.save_cart
		cookies.delete :cart_id
		flash.now[:notice] = "Your cart has been saved."
		redirect_to saved_carts_url
	end

	# GET /carts/1/activate
	# requires: user is logged in, @cart belongs to user,
	# 			@cart.status = "saved"
	# modifies: @cart, @current_cart
	# effects:
	# => saves current cart, if there is currently one active
	# => activates specified cart by setting status to "current"
	def activate
		if @current_cart
  	   		@current_cart.save_cart
    	end
		@cart = Cart.find_by_id(params[:id])
		@cart.activate
		cookies[:cart_id] = @cart.id
		redirect_to current_cart_url
	end

	# GET carts/1/checkout
	# prompts user to select a shipping address
	def checkout
		if cookies[:user_id]
			@addresses = User.find(cookies[:user_id]).addresses
			# TODO: take this out and implement checkout.html page w/address
			redirect_to review_url
		end
	end

	# GET carts/1/review
	# summarizes order before user confirms
	def review
		@cart = Cart.find_by_id(params[:id])
		if @cart.user_id == nil
			@cart.attach_to_user(@current_user.id)
		end
		display_price_changes(@cart.id)
		@items = @cart.items
		# TODO: incorporate address
		# @address = Address.find(params[:address_id])
	end

end

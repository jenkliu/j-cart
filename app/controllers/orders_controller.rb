class OrdersController < ApplicationController
	before_filter :require_admin_auth, :only => :show
	before_filter :require_user_login, :only => :create
	layout "admin", :only => :show

	# GET /admin/orders
	# displays all orders
	# requires: user is logged in and an Admin
	def show
		@orders = Order.all
	end


	#POST /orders
	# creates order for cart specified
	# requires: user is logged in, cart_id param defined
	# modifies: cart, orders, cookies
	# effects: 
	# => sets the specified cart's status to "ordered"
	# => creates a new order associated with the cart
	# => removes cart from session
	def create
		@cart = Cart.find(params[:cart_id])
		@cart.set_to_ordered
		# TODO: add address
		@order = Order.create(:cart_id => @cart.id)
		cookies.delete :cart_id

		flash[:notice] = "Your order has been placed!"
		redirect_to root_url
	end
end

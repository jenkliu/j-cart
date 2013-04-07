require 'test_helper'

class OrdersControllerTest < ActionController::TestCase
	test "create an order" do
		@cart = carts(:one)
		cookies[:cart_id] = 1
		cookies[:user_id] = 1

		assert_difference('Order.count') do
			post :create, :cart_id => @cart.id
		end
		assert_equal 'ordered', Cart.find(@cart.id).status
		assert_equal nil, cookies[:cart_id]

		assert_equal "Your order has been placed!", flash[:notice]
		assert_redirected_to '/'

	end

	test "should hide orders from non-admin" do
		cookies[:user_id] = 1
		get :show
		assert_equal "Oops! You do not have permission to view this page.", flash[:error]
	end

	test "should require user login" do
		get :show
		assert_redirected_to '/login'
		assert_response :redirect
	end

	test "should show orders to admin" do
		cookies[:user_id] = 2
		get :show
		assert_response :success
	end
	

end

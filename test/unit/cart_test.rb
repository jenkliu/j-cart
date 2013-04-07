require 'test_helper'

class CartTest < ActiveSupport::TestCase
  setup do
  	@cart = carts(:one)
  end

  test "save cart" do 
  	@cart.save_cart
  	assert_equal 'saved', carts(:one).status
  end

  test "activate cart" do 
  	@cart.activate
  	assert_equal 'current', carts(:one).status
  end

  test "attach cart to user" do
  	@cart.attach_to_user(1)
  	assert_equal 1, carts(:one).user_id
  end

  test "get total qty" do
  	qty = @cart.get_total_qty
  	assert_equal 4, qty
  end
end

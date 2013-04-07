require 'test_helper'

class ItemTest < ActiveSupport::TestCase
  setup do
  	@shoes_product = products(:shoes)
  	@shoes_item = items(:shoes_in_cart)
  end

  # before tests:
  # qty of shoes product: 27
  # qty of shoes in cart: 3
  test "increase item quantity" do
  	@shoes_item.change_qty(5)
  	assert_equal @shoes_item.qty, 5
  	assert_equal @shoes_item.product.qty_in_stock, 25
  end

  test "decrease item quantity" do
  	@shoes_item.change_qty(1)
  	assert_equal @shoes_item.qty, 1
  	assert_equal @shoes_item.product.qty_in_stock, 29
  end

  test "add item" do
  	@shoes_item.add
  	assert_equal @shoes_item.qty, 4
  	assert_equal @shoes_item.product.qty_in_stock, 26
  end
end

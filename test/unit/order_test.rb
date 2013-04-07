require 'test_helper'

class OrderTest < ActiveSupport::TestCase
  test "get total price" do 
  	total = orders(:one).get_total
  	assert_equal 114.99, total
  end
end

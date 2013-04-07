require 'test_helper'

class AdminAuthTest < ActionDispatch::IntegrationTest
  test "admin authentication" do
  	get_via_redirect '/admin/orders'
  	assert_equal '/login', path
  	assert_equal nil, cookies[:user_id]
  	
  	#post_via_redirect '/sessions', :email => 'admin@admin.com', :password => ':password'
  	#assert_equal 2, cookies[:user_id]

  	cookies[:user_id] = 2

  	get_via_redirect '/admin/orders'
  	assert_equal '/admin/orders', path
  end
end

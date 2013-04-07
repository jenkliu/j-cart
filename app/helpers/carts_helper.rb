module CartsHelper
	# checks if prices of items have changed, and if so, constructs bulleted flash
	# message for user
	# requires: cart_id is a valid cart id
	# modifies: prices of each item in cart, if associated product's price has changed
	# effects: updates price of each item in cart
	def display_price_changes(cart_id)
		cart = Cart.find_by_id(cart_id)
		changed_products = cart.get_price_changes
		if changed_products.length > 0
			msg = "The following items in your cart have a new price: <ul>"
			changed_products.each do |product|
				msg += "<li>" + product.name + " is now $" + product.price.to_s + "</li>"
			end
			msg += "</ul>"
			flash.now[:notice] = msg.html_safe
		end
	end

	# checks if logged-in user owns the cart provided in the url
	# if not, displays 403 error page
	def verify_ownership
		if @current_user.id != Cart.find(params[:id]).user.id
			flash.now[:error] = "Oops! You do not have permission to view this page."
			render :file => File.join(Rails.root, 'public', '403.html'), 
             	   :status => 403
		end
	end
end

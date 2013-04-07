class ItemsController < ApplicationController
	# POST items/edit
	# change quantity of item if there are enough in stock, otherwise inform user that there aren't
	# requires: item with id exists, :qty > 0
	# modifies: item, product
	# effects: item quantity is changed
	def edit
		@item = Item.find(params[:id])
		qty = params[:qty].to_i
		if @item.product.has_in_stock(qty)
			@item.change_qty(qty)
			flash.now[:notice] = "Your cart has been updated."
		else
			flash[:error] = "Sorry, there are only "+@item.product.qty_in_stock.to_s+" of "+ @item.product.name + " left in stock!"
		end
		redirect_to current_cart_url
	end

	# GET /items/1/remove
	# requires: item with id exists
	# modifies: item, product
	# effects:
	# => product quantity in stock is incremented by quantity of item
	# => item is destroyed
	def remove
		@item = Item.find(params[:id])
		@item.remove
		redirect_to current_cart_url
	end
		
end

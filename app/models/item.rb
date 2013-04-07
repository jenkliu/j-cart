class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  attr_accessible :price, :qty, :cart_id, :product_id, :name

  # add 1 to the item's quantity
  # modifies: qty of item, qty_in_stock of product
  # effects:
  # => increment qty of item by 1
  # => decrement qty_in_stock of product by 1
  def add
  	self.qty += 1
  	self.product.qty_in_stock -= 1
  	self.save
  	self.product.save
  end

  # modifies: qty_in_stock of product
  # effects:
  # => item is deleted
  # => qty_in_stock of product is decremented by qty of item
  def remove
    self.product.qty_in_stock += self.qty
    self.product.save
    self.destroy
  end

  # requires: new_qty is an int > 0 and <= qty_in_stock of product
  # modifies: qty of item
  # effects:
  # => qty of item is changed to [new_qty]
  # => qty_in_stock of product is changed by (self.qty - new_qty)
  def change_qty(new_qty)
  	old_qty = self.qty
  	self.qty = new_qty
  	self.product.qty_in_stock = self.product.qty_in_stock + old_qty - new_qty
  	self.save
  	self.product.save
  end

  # check if price is the same as product's current price
  def price_has_changed
  	if self.price != self.product.price
  		return true
  	else
  		return false
  	end
  end

  # update price to match current price of product
  def update_price
  	self.price = self.product.price
  	self.save
  end

end



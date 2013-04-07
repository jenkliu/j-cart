class Cart < ActiveRecord::Base
  has_many :items
  belongs_to :user
  has_one :order
  attr_accessible :status, :user_id

  # attaches cart to user
  # requires: param user_id is defined
  # modifies: user_id
  # effects: create association between cart and user
  def attach_to_user(user_id)
  	self.user_id = user_id
  	self.save
  end

  # returns the total quantity of all items in the cart
  def get_total_qty
    return self.items.sum(:qty)
  end

  # returns a list of items in the cart whose prices have changed
  # since they were added to the cart, or since the cart was last viewed
  # modifies: price of each item in cart, if associated product's price has changed
  # effects: updates prices of items to match products
  def get_price_changes
  	changed_products = []
  	self.items.each do |item|
  	 	if item.price_has_changed
  			item.update_price
			  changed_products.push item.product
		  end
	  end
	  return changed_products
  end

  # saves cart so that it can be re-activated later
  def save_cart
  	self.status = 'saved'
  	self.save
  end

  # activates cart (to be displayed in upper corner, so user
  #  can add and remove items from it)
  def activate
    self.status = 'current'
    self.save
  end

  # sets status of cart to 'ordered'
  def set_to_ordered
    self.status = "ordered"
    self.save
  end
end


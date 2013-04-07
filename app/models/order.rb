class Order < ActiveRecord::Base
  belongs_to :cart
  belongs_to :address
  attr_accessible :created_at, :cart_id, :address_id

  # returns the total price of all the items in the cart
  def get_total
  	return self.cart.items.sum(:price)
  end

end



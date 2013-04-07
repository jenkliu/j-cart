class Product < ActiveRecord::Base
  has_many :items
  validates_presence_of :name, :price, :qty_in_stock
  attr_accessible :brand, :info, :name, :price, :qty_in_stock, :items

  # check if product has at least [qty] in stock
  def has_in_stock(qty)
  	if self.qty_in_stock >= qty
  		return true
  	else
  		return false
  	end
  end

end

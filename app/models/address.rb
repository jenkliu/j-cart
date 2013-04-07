class Address < ActiveRecord::Base
  belongs_to :user
  has_many :orders
  attr_accessible :city, :state, :street_line1, :street_line2, :zip
end

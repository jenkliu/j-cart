class User < ActiveRecord::Base
  has_secure_password
  has_many :carts
  validates_presence_of :email, :password, :password_confirmation, :first_name, :last_name
  attr_accessible :email, :password, :password_confirmation, :first_name, :last_name
end

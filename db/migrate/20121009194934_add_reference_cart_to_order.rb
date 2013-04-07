class AddReferenceCartToOrder < ActiveRecord::Migration
  def change
  	change_table :carts do |t|
  		t.references :order
  	end
  end
end

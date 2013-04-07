class RemoveReferenceOrderFromCart < ActiveRecord::Migration
  def up
  	remove_column :carts, :order_id
  end

  def down
  	add_column :carts, :order_id, :integer
  end
end

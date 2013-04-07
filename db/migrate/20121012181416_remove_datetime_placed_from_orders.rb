class RemoveDatetimePlacedFromOrders < ActiveRecord::Migration
  def up
  	remove_column :orders, :datetime_placed
  end

  def down
  	add_column :orders, :datetime_placed, :integer
  end
end

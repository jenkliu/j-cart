class ChangeProductQtyToQtyInStock < ActiveRecord::Migration
  def up
  	change_table :products do |t|
  		t.rename :qty, :qty_in_stock
  	end 
  end

  def down
  	change_table :products do |t|
  		t.rename :qty_in_stock, :qty
  	end 
  end
end

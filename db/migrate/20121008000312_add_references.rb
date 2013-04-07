class AddReferences < ActiveRecord::Migration
  def up
  	change_table :items do |t|
  		t.references :cart, :product
  	end

  	change_table :carts do |t|
  		t.references :user
  	end
  end

  def down
  	execute << -SQL
  		ALTER TABLE carts
  			DROP FOREIGN KEY fk_carts_users
  		ALTER TABLE items
  			DROP FOREIGN KEY fk_items_carts
  			DROP FOREIGN KEY fk_items_products
  	SQL
  end
end

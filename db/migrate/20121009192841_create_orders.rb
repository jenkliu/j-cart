class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.datetime :datetime_placed
      t.references :cart
      t.references :address

      t.timestamps
    end
    add_index :orders, :cart_id
    add_index :orders, :address_id
  end
end

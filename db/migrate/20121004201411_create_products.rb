class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.float :price
      t.string :brand
      t.integer :qty
      t.text :info

      t.timestamps
    end
  end
end

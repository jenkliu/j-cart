class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :qty
      t.float :price

      t.timestamps
    end
  end
end

class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.string :street_line1
      t.string :street_line2
      t.string :city
      t.string :state
      t.integer :zip

      t.timestamps
    end
  end
end

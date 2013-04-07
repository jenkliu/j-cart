# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121106073849) do

  create_table "addresses", :force => true do |t|
    t.string    "street_line1"
    t.string    "street_line2"
    t.string    "city"
    t.string    "state"
    t.integer   "zip"
    t.timestamp "created_at",   :null => false
    t.timestamp "updated_at",   :null => false
  end

  create_table "carts", :force => true do |t|
    t.string    "type"
    t.string    "status"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "user_id"
  end

  create_table "items", :force => true do |t|
    t.integer   "qty"
    t.float     "price"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
    t.integer   "cart_id"
    t.integer   "product_id"
    t.string    "name"
  end

  create_table "orders", :force => true do |t|
    t.integer   "cart_id"
    t.integer   "address_id"
    t.timestamp "created_at", :null => false
    t.timestamp "updated_at", :null => false
  end

  add_index "orders", ["address_id"], :name => "index_orders_on_address_id"
  add_index "orders", ["cart_id"], :name => "index_orders_on_cart_id"

  create_table "products", :force => true do |t|
    t.string    "name"
    t.float     "price"
    t.string    "brand"
    t.integer   "qty_in_stock"
    t.text      "info"
    t.timestamp "created_at",   :null => false
    t.timestamp "updated_at",   :null => false
  end

  create_table "users", :force => true do |t|
    t.string    "email"
    t.string    "password_digest"
    t.timestamp "created_at",      :null => false
    t.timestamp "updated_at",      :null => false
    t.string    "type"
    t.string    "first_name"
    t.string    "last_name"
  end

end

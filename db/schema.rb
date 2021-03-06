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
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20141220123650) do

  create_table "customers", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "mail_address"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "matchings", force: true do |t|
    t.integer  "customer_id"
    t.integer  "store_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "enable_flg"
  end

  create_table "stores", force: true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.string   "geo_data"
    t.string   "mail_address"
    t.string   "memo"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "password"
    t.integer  "user_type",  limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "user_id"
    t.string   "salt"
  end

end

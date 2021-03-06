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

ActiveRecord::Schema.define(version: 20180418103123) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cities", force: :cascade do |t|
    t.string   "name"
    t.integer  "index_alphabet_id"
    t.integer  "state_id"
    t.string   "link"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "cities", ["index_alphabet_id"], name: "index_cities_on_index_alphabet_id", using: :btree
  add_index "cities", ["state_id"], name: "index_cities_on_state_id", using: :btree

  create_table "index_alphabets", force: :cascade do |t|
    t.string   "title"
    t.integer  "state_id"
    t.string   "link"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "index_alphabets", ["state_id"], name: "index_index_alphabets_on_state_id", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "id_from_rightmove"
    t.integer  "index_alphabet_id"
    t.integer  "state_id"
    t.integer  "city_id"
    t.string   "image_url"
    t.string   "property_for"
    t.string   "property_link"
    t.string   "latitude"
    t.string   "longitude"
    t.string   "address"
    t.string   "postal_code"
    t.string   "road"
    t.string   "city_name"
    t.string   "country"
    t.string   "state_name"
    t.string   "listed_on"
    t.string   "asking_price"
    t.string   "description"
    t.string   "beds"
    t.string   "last_sold_price"
    t.string   "last_sold_date"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "properties", ["city_id"], name: "index_properties_on_city_id", using: :btree
  add_index "properties", ["index_alphabet_id"], name: "index_properties_on_index_alphabet_id", using: :btree
  add_index "properties", ["state_id"], name: "index_properties_on_state_id", using: :btree

  create_table "states", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "cities", "index_alphabets"
  add_foreign_key "cities", "states"
  add_foreign_key "index_alphabets", "states"
  add_foreign_key "properties", "cities"
  add_foreign_key "properties", "index_alphabets"
  add_foreign_key "properties", "states"
end

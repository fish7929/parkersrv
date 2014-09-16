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

ActiveRecord::Schema.define(version: 20140916051003) do

  create_table "events", force: true do |t|
    t.string   "uuid"
    t.string   "rom_num"
    t.string   "event"
    t.datetime "last_time"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "information", force: true do |t|
    t.string   "uuid"
    t.string   "garage_name"
    t.integer  "total_parking_space"
    t.integer  "position"
    t.string   "longitude"
    t.string   "latitude"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "localities", force: true do |t|
    t.string   "uuid"
    t.string   "code"
    t.string   "parentId"
    t.string   "name"
    t.string   "garageNum"
    t.integer  "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "parkers", force: true do |t|
    t.string   "garage_name"
    t.string   "point"
    t.integer  "total_parking_spaces"
    t.integer  "remaining_parking_spaces"
    t.string   "address"
    t.float    "price",                    limit: 24
    t.integer  "isOpen"
    t.string   "status"
    t.integer  "road_garage"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "statuses", force: true do |t|
    t.string   "uuid"
    t.string   "garage_num"
    t.string   "parking_num"
    t.string   "rom_num"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "t_prov_city_area_street", force: true do |t|
    t.string  "code",     limit: 11
    t.string  "parentId", limit: 11
    t.string  "name",     limit: 50
    t.boolean "level"
  end

  create_table "tariffs", force: true do |t|
    t.string   "uuid"
    t.string   "time_range"
    t.float    "rates",          limit: 24
    t.integer  "information_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "tariffs", ["information_id"], name: "index_tariffs_on_information_id", using: :btree

end

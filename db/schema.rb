# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20081217075550) do

  create_table "comments", :force => true do |t|
    t.datetime "date"
    t.string   "text"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.string   "email"
    t.string   "phone"
    t.string   "note"
    t.boolean  "invoice"
    t.boolean  "deleted"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_types", :force => true do |t|
    t.string   "name"
    t.string   "note"
    t.string   "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "places", :force => true do |t|
    t.string   "name"
    t.string   "note"
    t.string   "photo"
    t.datetime "startDate"
    t.datetime "endDate"
    t.boolean  "deleted"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "projects", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "note"
    t.datetime "creationDate"
    t.datetime "finishDate"
    t.boolean  "deleted"
    t.integer  "user_id"
    t.integer  "project_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", :force => true do |t|
    t.integer  "idd"
    t.string   "name"
    t.string   "comment"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "name",       :limit => 40
    t.string   "login",      :limit => 40
    t.string   "password",   :limit => 40
    t.integer  "role"
    t.boolean  "deleted"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "works", :force => true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "note"
    t.datetime "startDate"
    t.datetime "endDate"
    t.boolean  "deleted"
    t.integer  "user_id"
    t.integer  "project_id"
    t.integer  "place_id"
    t.integer  "job_type_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

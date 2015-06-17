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

ActiveRecord::Schema.define(version: 20150617215652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.integer  "number"
    t.string   "title"
    t.string   "blurb"
    t.string   "filename"
    t.string   "category"
    t.text     "copy"
    t.datetime "posted_at"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "enabled"
    t.integer  "category_id"
  end

  add_index "articles", ["category_id"], name: "index_articles_on_category_id", using: :btree
  add_index "articles", ["number"], name: "index_articles_on_number", using: :btree

  create_table "categories", force: :cascade do |t|
    t.string   "title"
    t.integer  "articles_count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.text     "description"
  end

end

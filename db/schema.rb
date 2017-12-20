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


ActiveRecord::Schema.define(version: 20171219163732) do


  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attachinary_files", force: :cascade do |t|
    t.string   "attachinariable_type"
    t.integer  "attachinariable_id"
    t.string   "scope"
    t.string   "public_id"
    t.string   "version"
    t.integer  "width"
    t.integer  "height"
    t.string   "format"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["attachinariable_type", "attachinariable_id", "scope"], name: "by_scoped_parent", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.string   "url"
    t.string   "color"
    t.string   "original_store"
    t.integer  "size"
    t.integer  "price_cents"
    t.integer  "user_id"
    t.boolean  "favorite"
    t.integer  "user_price_cents"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.string   "src"
    t.string   "url_api"
    t.boolean  "notification",     default: false
    t.index ["user_id"], name: "index_items_on_user_id", using: :btree
  end

  create_table "notifications", force: :cascade do |t|
    t.integer  "item_id"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
    t.boolean  "read",             default: false
    t.integer  "old_price_cents"
    t.integer  "new_price_cents"
    t.boolean  "new_notification", default: true
    t.index ["item_id"], name: "index_notifications_on_item_id", using: :btree
  end

  create_table "prices", force: :cascade do |t|
    t.integer  "price_cents"
    t.string   "currency"
    t.integer  "item_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["item_id"], name: "index_prices_on_item_id", using: :btree
  end

  create_table "registrations", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_registrations_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_registrations_on_reset_password_token", unique: true, using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "surname"
    t.integer  "age"
    t.integer  "registration_id"
    t.datetime "created_at",                           null: false
    t.datetime "updated_at",                           null: false
    t.string   "provider"
    t.string   "uid"
    t.string   "facebook_picture_url"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "token"
    t.datetime "token_expiry"
    t.boolean  "admin",                default: false
    t.index ["registration_id"], name: "index_users_on_registration_id", using: :btree
  end

  add_foreign_key "items", "users"
  add_foreign_key "notifications", "items"
  add_foreign_key "prices", "items"
  add_foreign_key "users", "registrations"
end

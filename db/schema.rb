# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2022_03_11_120007) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "dream_labels", force: :cascade do |t|
    t.bigint "dream_id", null: false
    t.bigint "label_id", null: false
    t.bigint "user_id", null: false
    t.index ["dream_id"], name: "index_dream_labels_on_dream_id"
    t.index ["label_id"], name: "index_dream_labels_on_label_id"
    t.index ["user_id"], name: "index_dream_labels_on_user_id"
  end

  create_table "dreams", force: :cascade do |t|
    t.string "title"
    t.string "content"
    t.bigint "user_id", null: false
    t.bigint "significance_id"
    t.datetime "dream_date", default: "2022-07-23 11:06:33"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["significance_id"], name: "index_dreams_on_significance_id"
    t.index ["user_id"], name: "index_dreams_on_user_id"
  end

  create_table "labels", force: :cascade do |t|
    t.string "title"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "color", default: "#51C4D3"
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_labels_on_user_id"
  end

  create_table "significances", force: :cascade do |t|
    t.string "sign_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "importance", default: ""
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.string "first_name"
    t.string "last_name"
    t.string "role", default: "user"
    t.boolean "admin", default: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "dream_labels", "dreams"
  add_foreign_key "dream_labels", "labels"
  add_foreign_key "dream_labels", "users"
  add_foreign_key "dreams", "significances"
  add_foreign_key "dreams", "users"
  add_foreign_key "labels", "users"
end

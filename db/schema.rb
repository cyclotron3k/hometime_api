ActiveRecord::Schema[7.0].define(version: 2023_07_26_014916) do
  enable_extension "plpgsql"

  create_table "guests", force: :cascade do |t|
    t.string "email", null: false
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_guests_on_email", unique: true
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.bigint "guest_id", null: false
    t.string "number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["guest_id"], name: "index_phone_numbers_on_guest_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.bigint "guest_id", null: false
    t.string "code", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.integer "nights", null: false
    t.integer "guests", null: false
    t.integer "children", null: false
    t.integer "adults", null: false
    t.integer "infants", null: false
    t.string "status", null: false
    t.decimal "security_price", precision: 10, scale: 2, null: false
    t.decimal "payout_price", precision: 10, scale: 2, null: false
    t.decimal "total_price", precision: 10, scale: 2, null: false
    t.string "currency", limit: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_reservations_on_code", unique: true
    t.index ["guest_id"], name: "index_reservations_on_guest_id"
  end

  add_foreign_key "phone_numbers", "guests"
  add_foreign_key "reservations", "guests"
end

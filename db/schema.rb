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

ActiveRecord::Schema[8.1].define(version: 2026_04_15_023150) do
  create_table "business_settings", force: :cascade do |t|
    t.string "address", default: "Oranjestad, Aruba"
    t.datetime "created_at", null: false
    t.string "currency", default: "USD"
    t.string "email"
    t.text "footer_note"
    t.string "name", default: "Personal Concierge & Tours", null: false
    t.integer "payment_terms_days", default: 15
    t.string "phone"
    t.string "registration_label", default: "KvK Aruba"
    t.string "registration_number", default: "H42115.0"
    t.string "tagline", default: "Aruba Tourist Services"
    t.datetime "updated_at", null: false
  end

  create_table "clients", force: :cascade do |t|
    t.string "company"
    t.string "country"
    t.datetime "created_at", null: false
    t.string "email"
    t.string "name", null: false
    t.text "notes"
    t.string "phone"
    t.datetime "updated_at", null: false
    t.index ["company"], name: "index_clients_on_company"
    t.index ["name"], name: "index_clients_on_name"
  end

  create_table "invoices", force: :cascade do |t|
    t.integer "client_id", null: false
    t.datetime "created_at", null: false
    t.date "event_date"
    t.string "event_location"
    t.string "event_type"
    t.date "invoice_date", null: false
    t.string "invoice_number", null: false
    t.text "schedule_notes"
    t.string "status", default: "draft"
    t.decimal "tax_amount", precision: 10, scale: 2, default: "0.0"
    t.string "tax_label", default: "Aruba Health Tax/Fees"
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_invoices_on_client_id"
    t.index ["invoice_number"], name: "index_invoices_on_invoice_number", unique: true
    t.index ["status"], name: "index_invoices_on_status"
  end

  create_table "line_items", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "description", null: false
    t.integer "invoice_id", null: false
    t.integer "position", default: 0
    t.integer "quantity", default: 1
    t.decimal "unit_price", precision: 10, scale: 2, null: false
    t.datetime "updated_at", null: false
    t.index ["invoice_id"], name: "index_line_items_on_invoice_id"
  end

  add_foreign_key "invoices", "clients"
  add_foreign_key "line_items", "invoices"
end

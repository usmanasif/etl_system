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

ActiveRecord::Schema.define(version: 2019_02_05_002117) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointment_services", force: :cascade do |t|
    t.bigint "appointment_id"
    t.bigint "service_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reference_id"
    t.bigint "company_id"
    t.index ["appointment_id"], name: "index_appointment_services_on_appointment_id"
    t.index ["company_id"], name: "index_appointment_services_on_company_id"
    t.index ["reference_id"], name: "index_appointment_services_on_reference_id"
    t.index ["service_id"], name: "index_appointment_services_on_service_id"
  end

  create_table "appointments", force: :cascade do |t|
    t.datetime "begin_at", null: false
    t.datetime "end_at", null: false
    t.bigint "client_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reference_id"
    t.bigint "company_id"
    t.index ["client_id"], name: "index_appointments_on_client_id"
    t.index ["company_id"], name: "index_appointments_on_company_id"
    t.index ["reference_id"], name: "index_appointments_on_reference_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reference_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_clients_on_company_id"
    t.index ["email"], name: "index_clients_on_email"
    t.index ["reference_id"], name: "index_clients_on_reference_id"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", limit: 50, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "services", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reference_id"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_services_on_company_id"
    t.index ["reference_id"], name: "index_services_on_reference_id"
  end

end

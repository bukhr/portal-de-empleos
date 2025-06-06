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

ActiveRecord::Schema[8.0].define(version: 2025_06_05_203356) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "companies", force: :cascade do |t|
    t.string "identifier_value"
    t.integer "identifier_type"
    t.string "name"
    t.string "fantasy_name"
    t.string "image_url"
    t.string "background_color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_offer_references", force: :cascade do |t|
    t.integer "source"
    t.string "external_id"
    t.string "external_url"
    t.string "public_token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "job_offers", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.bigint "job_offer_reference_id", null: false
    t.integer "status", default: 0
    t.string "name"
    t.string "description"
    t.string "requirements"
    t.string "job_area"
    t.string "job_department"
    t.string "job_division"
    t.string "job_type"
    t.integer "job_schedule"
    t.integer "vacancies_count"
    t.boolean "show_location"
    t.string "location"
    t.boolean "show_published_at"
    t.date "published_at"
    t.boolean "show_salary_range"
    t.integer "min_salary"
    t.integer "max_salary"
    t.boolean "use_fantasy_name"
    t.boolean "visible"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id"], name: "index_job_offers_on_company_id"
    t.index ["job_offer_reference_id"], name: "index_job_offers_on_job_offer_reference_id"
  end

  add_foreign_key "job_offers", "companies"
  add_foreign_key "job_offers", "job_offer_references"
end

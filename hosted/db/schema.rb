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

ActiveRecord::Schema.define(version: 2020_05_03_175728) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "inbound_messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "inbox_id"
    t.uuid "sender_id"
    t.string "status", default: "received"
    t.string "sender_name", null: false
    t.string "sender_email", null: false
    t.text "raw_body", null: false
    t.datetime "received_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "spam", default: false, null: false
    t.index ["inbox_id"], name: "index_inbound_messages_on_inbox_id"
    t.index ["sender_id"], name: "index_inbound_messages_on_sender_id"
  end

  create_table "inbox_permissions", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "person_id"
    t.uuid "inbox_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["inbox_id"], name: "index_inbox_permissions_on_inbox_id"
    t.index ["person_id"], name: "index_inbox_permissions_on_person_id"
  end

  create_table "inboxes", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name", null: false
    t.boolean "redirect_on_completion", default: false
    t.string "redirect_on_success_url"
    t.string "redirect_on_failure_url"
    t.text "confirmation_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "slug"
    t.boolean "honeytrap", default: false, null: false
    t.index ["slug"], name: "index_inboxes_on_slug", unique: true
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "recipient_id"
    t.string "topic", null: false
    t.string "status", default: "undelivered"
    t.string "address", null: false
    t.string "via", default: "email", null: false
    t.string "receiptable_type", null: false
    t.uuid "receiptable_id", null: false
    t.datetime "delivered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiptable_type", "receiptable_id"], name: "index_receipts_on_receiptable_type_and_receiptable_id"
    t.index ["recipient_id"], name: "index_receipts_on_recipient_id"
  end

  create_table "team_members", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "public_schedule_slug", null: false
    t.string "public_schedule_availability_email_address", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["public_schedule_availability_email_address"], name: "public_schedule_availability_email"
    t.index ["public_schedule_slug"], name: "public_schedule_slug"
  end

end

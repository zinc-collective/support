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

ActiveRecord::Schema.define(version: 2019_06_04_000631) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pgcrypto"
  enable_extension "plpgsql"

  create_table "inbound_messages", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "inbox_id"
    t.uuid "sender_id"
    t.string "status", default: "received"
    t.string "sender_name"
    t.string "sender_email"
    t.text "raw_body"
    t.datetime "received_at", default: -> { "CURRENT_TIMESTAMP" }
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "name"
    t.boolean "redirect_on_completion"
    t.string "redirect_on_completion_url"
    t.text "confirmation_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "people", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "receipts", id: :uuid, default: -> { "gen_random_uuid()" }, force: :cascade do |t|
    t.uuid "recipient_id"
    t.string "topic"
    t.string "status", default: "undelivered"
    t.string "address", null: false
    t.string "via", default: "email"
    t.string "receiptable_type", null: false
    t.uuid "receiptable_id", null: false
    t.datetime "delivered_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["receiptable_type", "receiptable_id"], name: "index_receipts_on_receiptable_type_and_receiptable_id"
    t.index ["recipient_id"], name: "index_receipts_on_recipient_id"
  end

end

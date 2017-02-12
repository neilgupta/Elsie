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

ActiveRecord::Schema.define(version: 20170212035722) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",                   default: 0
    t.integer  "attempts",                   default: 0
    t.text     "handler"
    t.text     "last_error"
    t.string   "queue",          limit: 255
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",      limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag",            limit: 255
    t.integer  "max_attempts"
    t.string   "strand",         limit: 255
    t.boolean  "next_in_strand",             default: true, null: false
    t.string   "source",         limit: 255
    t.integer  "max_concurrent",             default: 1,    null: false
    t.datetime "expires_at"
    t.index ["locked_by"], name: "index_delayed_jobs_on_locked_by", where: "(locked_by IS NOT NULL)", using: :btree
    t.index ["priority", "run_at", "queue"], name: "get_delayed_jobs_index", where: "((locked_at IS NULL) AND (next_in_strand = true))", using: :btree
    t.index ["run_at", "tag"], name: "index_delayed_jobs_on_run_at_and_tag", using: :btree
    t.index ["strand", "id"], name: "index_delayed_jobs_on_strand", using: :btree
    t.index ["tag"], name: "index_delayed_jobs_on_tag", using: :btree
  end

  create_table "devices", force: :cascade do |t|
    t.boolean  "occupancy",     default: false, null: false
    t.boolean  "connected",     default: false, null: false
    t.string   "mac",                           null: false
    t.string   "friendly_name"
    t.string   "hostname"
    t.string   "ip"
    t.datetime "expires_at"
    t.datetime "last_seen_at"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["mac"], name: "index_devices_on_mac", unique: true, using: :btree
  end

  create_table "failed_jobs", force: :cascade do |t|
    t.integer  "priority",                       default: 0
    t.integer  "attempts",                       default: 0
    t.string   "handler",         limit: 512000
    t.text     "last_error"
    t.string   "queue",           limit: 255
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by",       limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tag",             limit: 255
    t.integer  "max_attempts"
    t.string   "strand",          limit: 255
    t.bigint   "original_job_id"
    t.string   "source",          limit: 255
    t.datetime "expires_at"
  end

end

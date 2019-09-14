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

ActiveRecord::Schema.define(version: 2019_09_14_032843) do

  create_table "comments", force: :cascade do |t|
    t.string "content", null: false
    t.integer "user_id"
    t.integer "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "unknown_user_id"
    t.index ["event_id"], name: "index_comments_on_event_id"
    t.index ["unknown_user_id"], name: "index_comments_on_unknown_user_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id", null: false
    t.string "event_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "content"
    t.index ["event_code"], name: "index_events_on_event_code", unique: true
    t.index ["user_id"], name: "index_events_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.integer "user_id"
    t.integer "unknown_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "comment_id"
    t.index ["comment_id"], name: "index_likes_on_comment_id"
    t.index ["unknown_user_id"], name: "index_likes_on_unknown_user_id"
    #rails console: ActiveRecord::Migration.remove_index "likes", name: "index_likes_on_unknown_user_id_and_event_id"を実行　9月14日
    t.index ["unknown_user_id"], name: "index_likes_on_unknown_user_id_and_event_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
    # rails console: ActiveRecord::Migration.remove_index "likes", name: "index_likes_on_user_id_and_event_id"を実行済み 9月14日
    t.index ["user_id"], name: "index_likes_on_user_id_and_event_id", unique: true
  end

  create_table "unknown_users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name", null: false
    t.string "mail", null: false
    t.string "password_digest", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["mail"], name: "index_users_on_mail", unique: true
    t.index ["name"], name: "index_users_on_name"
  end

end

# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20151016185729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "answers", force: :cascade do |t|
    t.text     "answer"
    t.integer  "question_id", null: false
    t.integer  "user_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "answers", ["question_id"], name: "index_answers_on_question_id", using: :btree
  add_index "answers", ["user_id"], name: "index_answers_on_user_id", using: :btree

  create_table "asked_to_answers", force: :cascade do |t|
    t.integer  "question_id"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "asked_to_answers", ["question_id"], name: "index_asked_to_answers_on_question_id", using: :btree
  add_index "asked_to_answers", ["user_id"], name: "index_asked_to_answers_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.integer  "entity_id",   null: false
    t.string   "entity_type", null: false
    t.string   "comment"
    t.integer  "user_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "comments", ["entity_id", "entity_type"], name: "index_comments_on_entity_id_and_entity_type", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "notifications", force: :cascade do |t|
    t.string   "description"
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.boolean  "seen_flag"
  end

  add_index "notifications", ["question_id"], name: "index_notifications_on_question_id", using: :btree
  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "questions", force: :cascade do |t|
    t.string   "title"
    t.text     "description"
    t.integer  "user_id",       null: false
    t.integer  "repository_id", null: false
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  add_index "questions", ["repository_id"], name: "index_questions_on_repository_id", using: :btree
  add_index "questions", ["user_id"], name: "index_questions_on_user_id", using: :btree

  create_table "repo_contributors", force: :cascade do |t|
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "user_id"
    t.integer  "repository_id"
    t.integer  "contributions"
  end

  create_table "repositories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tag_users", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "question_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tag_users", ["question_id"], name: "index_tag_users_on_question_id", using: :btree
  add_index "tag_users", ["user_id"], name: "index_tag_users_on_user_id", using: :btree

  create_table "user_repo_joins", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "repository_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password"
    t.boolean  "set_flag"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "votes", force: :cascade do |t|
    t.integer  "entity_id",   null: false
    t.string   "entity_type", null: false
    t.integer  "user_id",     null: false
    t.boolean  "vote_flag"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "votes", ["entity_id", "entity_type"], name: "index_votes_on_entity_id_and_entity_type", using: :btree
  add_index "votes", ["user_id"], name: "index_votes_on_user_id", using: :btree

  add_foreign_key "answers", "questions"
  add_foreign_key "answers", "users"
  add_foreign_key "asked_to_answers", "questions"
  add_foreign_key "asked_to_answers", "users"
  add_foreign_key "comments", "users"
  add_foreign_key "notifications", "questions"
  add_foreign_key "notifications", "users"
  add_foreign_key "questions", "repositories"
  add_foreign_key "questions", "users"
  add_foreign_key "tag_users", "questions"
  add_foreign_key "tag_users", "users"
  add_foreign_key "votes", "users"
end

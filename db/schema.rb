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

ActiveRecord::Schema.define(version: 20161019015859) do

  create_table "answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",     limit: 65535
    t.boolean  "is_correct"
    t.integer  "question_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["question_id"], name: "index_answers_on_question_id", using: :btree
  end

  create_table "exam_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",          limit: 65535
    t.boolean  "is_choice"
    t.integer  "exam_question_id"
    t.integer  "answer_id"
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
    t.index ["answer_id"], name: "index_exam_answers_on_answer_id", using: :btree
    t.index ["exam_question_id"], name: "index_exam_answers_on_exam_question_id", using: :btree
  end

  create_table "exam_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",     limit: 65535
    t.boolean  "is_correct"
    t.integer  "exam_id"
    t.integer  "question_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["exam_id"], name: "index_exam_questions_on_exam_id", using: :btree
    t.index ["question_id"], name: "index_exam_questions_on_question_id", using: :btree
  end

  create_table "exams", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "status"
    t.datetime "started_at"
    t.integer  "spent_time"
    t.integer  "score"
    t.integer  "user_id"
    t.integer  "subject_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["subject_id"], name: "index_exams_on_subject_id", using: :btree
    t.index ["user_id"], name: "index_exams_on_user_id", using: :btree
  end

  create_table "questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "answer_type"
    t.text     "content",     limit: 65535
    t.integer  "status"
    t.integer  "level"
    t.integer  "subject_id"
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
    t.index ["subject_id"], name: "index_questions_on_subject_id", using: :btree
  end

  create_table "subjects", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.integer  "question_number"
    t.integer  "hard"
    t.integer  "medium"
    t.integer  "easy"
    t.integer  "duration"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "suggest_answers", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.text     "content",             limit: 65535
    t.boolean  "is_correct"
    t.integer  "suggest_question_id"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.index ["suggest_question_id"], name: "index_suggest_answers_on_suggest_question_id", using: :btree
  end

  create_table "suggest_questions", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.integer  "status"
    t.integer  "type"
    t.text     "content",    limit: 65535
    t.integer  "user_id"
    t.integer  "subject_id"
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
    t.index ["subject_id"], name: "index_suggest_questions_on_subject_id", using: :btree
    t.index ["user_id"], name: "index_suggest_questions_on_user_id", using: :btree
  end

  create_table "users", force: :cascade, options: "ENGINE=InnoDB DEFAULT CHARSET=utf8" do |t|
    t.string   "name"
    t.string   "chatwork_id"
    t.integer  "role",                   default: 1
    t.string   "avatar"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "answers", "questions"
  add_foreign_key "exam_answers", "answers"
  add_foreign_key "exam_answers", "exam_questions"
  add_foreign_key "exam_questions", "exams"
  add_foreign_key "exam_questions", "questions"
  add_foreign_key "exams", "subjects"
  add_foreign_key "exams", "users"
  add_foreign_key "questions", "subjects"
  add_foreign_key "suggest_answers", "suggest_questions"
  add_foreign_key "suggest_questions", "subjects"
  add_foreign_key "suggest_questions", "users"
end

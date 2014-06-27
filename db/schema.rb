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

ActiveRecord::Schema.define(version: 20140625135058) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "constraints", force: true do |t|
    t.string   "major_type"
    t.string   "term"
    t.boolean  "pre_requisite"
    t.boolean  "anti_requisite"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "constraints_courses", force: true do |t|
    t.integer "course_id"
    t.integer "constraint_id"
  end

  create_table "courses", force: true do |t|
    t.string   "short_form"
    t.text     "title"
    t.text     "description"
    t.string   "terms_offered"
    t.string   "course_type"
    t.float    "required_grade"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "courses_requirements", force: true do |t|
    t.integer "course_id"
    t.integer "requirement_id"
  end

  create_table "majors", force: true do |t|
    t.string   "name"
    t.string   "short_form"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "options", force: true do |t|
    t.string   "name"
    t.integer  "major_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "requirements", force: true do |t|
    t.integer  "major_id"
    t.integer  "option_id"
    t.string   "name"
    t.string   "course_type"
    t.integer  "requirement_count"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end

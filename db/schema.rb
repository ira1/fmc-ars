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

ActiveRecord::Schema.define(version: 20141117125431) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: true do |t|
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "surveys", force: true do |t|
    t.string   "respondentid"
    t.integer  "batch"
    t.boolean  "full_time"
    t.float    "age"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "primary_genre_group"
    t.boolean  "role_composer"
    t.boolean  "role_recording"
    t.boolean  "role_salaried"
    t.boolean  "role_performer"
    t.boolean  "role_session"
    t.integer  "birth_year"
    t.integer  "age_group"
    t.integer  "experience_group"
    t.string   "hours_group"
    t.string   "integer"
    t.boolean  "member_pro"
    t.boolean  "member_music_org"
    t.integer  "genre_group_1"
    t.integer  "money_genre_group_1"
    t.integer  "pie_song"
    t.integer  "pie_salary"
    t.integer  "pie_live"
    t.integer  "pie_record"
    t.integer  "pie_session"
    t.integer  "pie_merch"
    t.integer  "pie_teach"
    t.integer  "pie_other"
    t.integer  "compose_inc_direction"
    t.integer  "salary_inc_direction"
    t.integer  "perform_inc_direction"
    t.integer  "record_inc_direction"
    t.integer  "session_inc_direction"
    t.integer  "merch_inc_direction"
    t.integer  "teach_inc_direction"
    t.boolean  "rev_youtube"
    t.boolean  "rev_webads"
    t.boolean  "rev_fanfund"
    t.boolean  "rev_fanclub"
    t.boolean  "rev_persona"
    t.boolean  "rev_endorse"
    t.boolean  "rev_acting"
    t.boolean  "rev_corp"
    t.boolean  "rev_sample"
    t.boolean  "rev_honoraria"
    t.boolean  "rev_grants"
    t.boolean  "rev_produce"
    t.boolean  "rev_pubadvance"
    t.boolean  "ascaplus"
    t.boolean  "aarc"
    t.boolean  "afm_2"
    t.boolean  "afm_srsp"
    t.boolean  "afm_aftra"
    t.boolean  "aftra_csp"
    t.boolean  "label_settle"
    t.float    "music_inc_share_pct"
    t.string   "income_strata"
    t.integer  "income_strata_group"
    t.integer  "emi"
    t.integer  "seasoning_group"
    t.integer  "path_group"
    t.boolean  "role_teacher"
    t.integer  "freq_commercial_radio"
    t.integer  "freq_noncommercial_radio"
    t.integer  "freq_internet_radio"
    t.integer  "freq_satellite_radio"
    t.integer  "freq_cable_radio"
    t.integer  "comfort_net_produce"
    t.integer  "comfort_net_promote"
    t.integer  "comfort_net_distribute"
    t.integer  "comfort_net_collaborate"
    t.integer  "comfort_net_fanconnect"
    t.string   "gender"
    t.integer  "gender_group"
    t.integer  "edu_level_group"
    t.boolean  "music_school"
    t.string   "zip"
    t.integer  "credits_compositions_life"
    t.integer  "credits_recordings_life"
    t.integer  "shows_last_year"
    t.integer  "credits_sessions_life"
    t.float    "latitude"
    t.float    "longitude"
    t.integer  "experience_group_consolidated"
  end

  create_table "surveytests", force: true do |t|
    t.string   "respondentid"
    t.float    "age"
    t.integer  "age_group"
    t.integer  "experience_group"
    t.string   "hours_group"
    t.string   "integer"
    t.boolean  "member_pro"
    t.boolean  "member_music_org"
    t.integer  "genre_group_1"
    t.integer  "money_genre_group_1"
    t.string   "pie_song"
    t.integer  "pie_salary"
    t.integer  "pie_live"
    t.integer  "pie_record"
    t.integer  "pie_session"
    t.integer  "pie_merch"
    t.integer  "pie_teach"
    t.integer  "pie_other"
    t.integer  "compose_inc_direction"
    t.integer  "salary_inc_direction"
    t.integer  "perform_inc_direction"
    t.integer  "record_inc_direction"
    t.integer  "session_inc_direction"
    t.integer  "merch_inc_direction"
    t.integer  "teach_inc_direction"
    t.boolean  "rev_youtube"
    t.boolean  "rev_webads"
    t.boolean  "rev_fanfund"
    t.boolean  "rev_fanclub"
    t.boolean  "rev_persona"
    t.boolean  "rev_endorse"
    t.boolean  "rev_acting"
    t.boolean  "rev_corp"
    t.boolean  "rev_sample"
    t.boolean  "rev_honoraria"
    t.boolean  "rev_grants"
    t.boolean  "rev_produce"
    t.boolean  "rev_pubadvance"
    t.boolean  "ascaplus"
    t.boolean  "aarc"
    t.boolean  "afm_2"
    t.boolean  "afm_srsp"
    t.boolean  "afm_aftra"
    t.boolean  "aftra_csp"
    t.boolean  "label_settle"
    t.float    "music_inc_share_pct"
    t.string   "income_strata"
    t.integer  "income_strata_group"
    t.integer  "emi"
    t.boolean  "full_time"
    t.integer  "seasoning_group"
    t.integer  "path_group"
    t.boolean  "role_compose"
    t.boolean  "role_record"
    t.boolean  "role_perform"
    t.boolean  "role_session"
    t.boolean  "role_teach"
    t.integer  "freq_commercial_radio"
    t.integer  "freq_noncommercial_radio"
    t.integer  "freq_internet_radio"
    t.integer  "freq_satellite_radio"
    t.integer  "freq_cable_radio"
    t.integer  "comfort_net_produce"
    t.integer  "comfort_net_promote"
    t.integer  "comfort_net_distribute"
    t.integer  "comfort_net_collaborate"
    t.integer  "comfort_net_fanconnect"
    t.string   "gender"
    t.integer  "gender_group"
    t.integer  "edu_level_group"
    t.boolean  "music_school"
    t.string   "zip"
    t.integer  "credits_compose_life"
    t.integer  "credits_record_life"
    t.integer  "credits_show_life"
    t.integer  "credits_session_life"
    t.integer  "shows_last_year"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "birth_year"
  end

end

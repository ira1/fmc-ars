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

ActiveRecord::Schema.define(version: 20151021233234) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countyfips", id: false, force: true do |t|
    t.string "state"
    t.string "county"
    t.string "fips"
  end

  create_table "imp_surveys", force: true do |t|
    t.string   "respondentid"
    t.string   "collectorid"
    t.string   "startdate"
    t.string   "enddate"
    t.string   "completetime"
    t.string   "ipaddress"
    t.string   "consent"
    t.integer  "birth_year"
    t.float    "age"
    t.integer  "age_group"
    t.string   "citizen"
    t.string   "experience"
    t.integer  "experience_group"
    t.string   "hours"
    t.integer  "hours_group"
    t.string   "perspective"
    t.string   "ascap"
    t.string   "bmi"
    t.string   "sesac"
    t.string   "soundexchange"
    t.string   "no_pro"
    t.boolean  "member_pro"
    t.string   "foreign_pro"
    t.string   "afm"
    t.string   "aftra"
    t.string   "agma"
    t.string   "sag"
    t.string   "naras"
    t.string   "songguild"
    t.string   "nsai"
    t.string   "countryma"
    t.string   "acf"
    t.string   "amc"
    t.string   "mtc"
    t.string   "chamberma"
    t.string   "jen"
    t.string   "aaj"
    t.string   "jazzcorner"
    t.string   "ama"
    t.string   "ema"
    t.string   "folkalliance"
    t.string   "jpf"
    t.string   "gma"
    t.string   "ibma"
    t.string   "fracatlas"
    t.string   "napama"
    t.string   "apap"
    t.string   "no_music_org"
    t.boolean  "member_music_org"
    t.string   "other_music_org"
    t.string   "genre1"
    t.string   "primary_genre_consolidated"
    t.integer  "genre_group_1"
    t.string   "genre2"
    t.string   "genre3"
    t.string   "other_genre"
    t.string   "moneygenre1"
    t.string   "moneygenre_consolidated"
    t.integer  "money_genre_group_1"
    t.string   "moneygenre2"
    t.string   "cowriter"
    t.string   "band"
    t.string   "producer"
    t.string   "label"
    t.string   "publisher"
    t.string   "bizmanager"
    t.string   "booking"
    t.string   "tourmanager"
    t.string   "soundperson"
    t.string   "roadcrew"
    t.string   "publicist"
    t.string   "fanstreetteam"
    t.string   "webmaster"
    t.string   "graphicdesign"
    t.string   "accountant"
    t.string   "attorney"
    t.string   "other_team_member"
    t.integer  "pie_song"
    t.integer  "pie_salary"
    t.integer  "pie_live"
    t.integer  "pie_record"
    t.integer  "pie_session"
    t.integer  "pie_merch"
    t.integer  "pie_teach"
    t.integer  "pie_other"
    t.string   "pie_total"
    t.string   "change_song"
    t.integer  "compose_inc_direction"
    t.string   "change_salary"
    t.integer  "salary_inc_direction"
    t.string   "change_live"
    t.integer  "perform_inc_direction"
    t.string   "change_record"
    t.integer  "record_inc_direction"
    t.string   "change_session"
    t.integer  "session_inc_direction"
    t.string   "change_merch"
    t.integer  "merch_inc_direction"
    t.string   "change_teach"
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
    t.string   "income"
    t.string   "midrange_income"
    t.float    "music_inc_share_pct"
    t.string   "income_strata"
    t.integer  "income_strata_group"
    t.integer  "emi"
    t.boolean  "full_time"
    t.integer  "seasoning_group"
    t.string   "path"
    t.integer  "path_group"
    t.string   "short_role_music"
    t.string   "short_role_lyrics"
    t.string   "short_role_composer"
    t.string   "short_role_recording"
    t.string   "short_role_record"
    t.string   "short_role_perform_desc"
    t.string   "short_role_perform"
    t.string   "short_role_orchestra_desc"
    t.string   "short_role_orchestra"
    t.string   "short_role_session_desc"
    t.string   "short_role_session"
    t.string   "short_role_teach_desc"
    t.string   "short_role_teach"
    t.string   "short_role_admin_desc"
    t.string   "short_role_admin"
    t.string   "short_moneyrole"
    t.string   "med_moneyrole"
    t.string   "long_composer"
    t.string   "long_recordings"
    t.string   "long_liveperformance"
    t.string   "long_session"
    t.string   "long_teacher"
    t.boolean  "role_composer"
    t.boolean  "role_recording"
    t.boolean  "role_performer"
    t.boolean  "role_session"
    t.boolean  "role_teacher"
    t.string   "other_inc_streams"
    t.string   "other_dec_streams"
    t.string   "confirm_perspective"
    t.string   "radio_com"
    t.integer  "freq_commercial_radio"
    t.string   "radio_noncom"
    t.integer  "freq_noncommercial_radio"
    t.string   "radio_internet"
    t.integer  "freq_internet_radio"
    t.string   "radio_satellite"
    t.integer  "freq_satellite_radio"
    t.string   "radio_cable"
    t.integer  "freq_cable_radio"
    t.string   "web_produce"
    t.integer  "comfort_net_produce"
    t.string   "web_promote"
    t.integer  "comfort_net_promote"
    t.string   "web_distro"
    t.integer  "comfort_net_distribute"
    t.string   "web_collab"
    t.integer  "comfort_net_collaborate"
    t.string   "web_fans"
    t.integer  "comfort_net_fanconnect"
    t.string   "ableton"
    t.string   "garageband"
    t.string   "digitalperformer"
    t.string   "finale"
    t.string   "logic"
    t.string   "maximuspe"
    t.string   "prop_reason"
    t.string   "prop_record"
    t.string   "pro_tools"
    t.string   "sibelius"
    t.string   "virtual_dj"
    t.string   "other_software"
    t.string   "webblog"
    t.string   "bandcamp"
    t.string   "bandletter"
    t.string   "bandzoogle"
    t.string   "cash_music"
    t.string   "cdbaby"
    t.string   "facebook"
    t.string   "fanbridge"
    t.string   "flickr"
    t.string   "foursquare"
    t.string   "mailchimp"
    t.string   "myspace"
    t.string   "nextbigsound"
    t.string   "nimbit"
    t.string   "reverbnation"
    t.string   "rootmusic"
    t.string   "rumblefish"
    t.string   "songkick"
    t.string   "sonicbids"
    t.string   "soundcloud"
    t.string   "taxi"
    t.string   "topspin"
    t.string   "tumblr"
    t.string   "tunecore"
    t.string   "twitter"
    t.string   "youtube"
    t.string   "other_web_dist"
    t.string   "tech_money"
    t.string   "tech_self"
    t.string   "tech_collab"
    t.string   "tech_fans"
    t.string   "tech_merits"
    t.string   "tech_compete"
    t.string   "tech_promo"
    t.string   "tech_devalue"
    t.string   "tech_piracy"
    t.string   "tech_control"
    t.string   "time_compose"
    t.string   "time_perform"
    t.string   "time_record"
    t.string   "time_collab"
    t.string   "time_session"
    t.string   "time_teach"
    t.string   "time_socnet"
    t.string   "time_manage"
    t.string   "time_account"
    t.string   "time_fundraise"
    t.string   "learn_about_survey"
    t.string   "survey_source"
    t.string   "gender"
    t.string   "gender_group"
    t.string   "race_ethnicity"
    t.string   "education_level"
    t.integer  "edu_level_group"
    t.boolean  "music_school"
    t.string   "music_degree"
    t.string   "specific_degree"
    t.string   "health_ins"
    t.string   "pension"
    t.string   "zip"
    t.string   "msa"
    t.string   "msa_code"
    t.string   "med_compcred12mos"
    t.string   "med_compcredcareer"
    t.string   "med_comp_credits_lifetime"
    t.string   "med_reccred12mos"
    t.string   "med_reccredcareer"
    t.string   "med_recording_credits_lifetime"
    t.string   "med_numshows"
    t.string   "med_shows_12months"
    t.string   "med_sesscred12mos"
    t.string   "med_sesscredcareer"
    t.string   "med_session_credits_lifetime"
    t.string   "long_compcred12mos"
    t.string   "long_compcredcareer"
    t.string   "long_composition_credits_lifetime"
    t.string   "long_reccred12mos"
    t.string   "long_reccredcareer"
    t.string   "long_recording_credits_lifetime"
    t.string   "long_numshows"
    t.string   "long_shows_last_year"
    t.string   "long_sesscred12mos"
    t.string   "long_sesscredcareer"
    t.string   "long_session_credits_lifetime"
    t.integer  "credits_compositions_life"
    t.integer  "credits_recordings_life"
    t.integer  "shows_last_year"
    t.integer  "credits_sessions_life"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "role_salaried"
    t.boolean  "role_other"
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
    t.string   "gender_group"
    t.integer  "edu_level_group"
    t.boolean  "music_school"
    t.string   "zip"
    t.integer  "credits_compositions_life"
    t.integer  "credits_recordings_life"
    t.integer  "shows_last_year"
    t.integer  "credits_sessions_life"
    t.float    "latitude"
    t.float    "longitude"
    t.boolean  "role_other"
    t.integer  "midrange_income"
    t.string   "countyfips"
    t.string   "state"
    t.string   "countyname"
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

  create_table "testrow", id: false, force: true do |t|
    t.boolean "col1"
    t.boolean "col2"
    t.boolean "col3"
    t.boolean "colnull"
  end

  create_table "zc", id: false, force: true do |t|
    t.string "zip"
    t.string "cname"
    t.string "cfips"
    t.string "msa"
    t.string "state", limit: 2
  end

  add_index "zc", ["zip"], name: "zip_unique", unique: true, using: :btree

  create_table "zipmap1", id: false, force: true do |t|
    t.string "zip"
    t.string "ztype"
    t.string "primary_city"
    t.string "state"
    t.string "county"
    t.string "latitude"
    t.string "longitude"
    t.string "fips"
  end

end

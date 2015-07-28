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

ActiveRecord::Schema.define(version: 20150728164153) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "advanced_stats", force: true do |t|
    t.integer  "player_id"
    t.string   "year"
    t.decimal  "games"
    t.decimal  "mp"
    t.decimal  "per"
    t.decimal  "ts_pct"
    t.decimal  "three_par"
    t.decimal  "ftr"
    t.decimal  "orb_pct"
    t.decimal  "drb_pct"
    t.decimal  "trb_pct"
    t.decimal  "ast_pct"
    t.decimal  "stl_pct"
    t.decimal  "blk_pct"
    t.decimal  "tov_pct"
    t.decimal  "usg_pct"
    t.decimal  "ows"
    t.decimal  "dws"
    t.decimal  "ws"
    t.decimal  "ws_48"
    t.decimal  "obpm"
    t.decimal  "dbpm"
    t.decimal  "bpm"
    t.decimal  "vorp"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "age"
    t.string   "pos"
  end

  add_index "advanced_stats", ["player_id"], name: "index_advanced_stats_on_player_id", using: :btree

  create_table "boxscores", force: true do |t|
    t.integer  "player_id"
    t.datetime "game_date"
    t.string   "player_name"
    t.integer  "minutes"
    t.integer  "seconds"
    t.decimal  "fgm"
    t.decimal  "fga"
    t.decimal  "fg_pct"
    t.decimal  "tpm"
    t.decimal  "tpa"
    t.decimal  "tp_pct"
    t.decimal  "ftm"
    t.decimal  "fta"
    t.decimal  "ft_pct"
    t.decimal  "orb"
    t.decimal  "drb"
    t.decimal  "trb"
    t.decimal  "assists"
    t.decimal  "steals"
    t.decimal  "blocks"
    t.decimal  "tov"
    t.decimal  "pf"
    t.decimal  "points"
    t.integer  "plus_minus"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "game_id"
  end

  add_index "boxscores", ["game_id"], name: "index_boxscores_on_game_id", using: :btree
  add_index "boxscores", ["player_id"], name: "index_boxscores_on_player_id", using: :btree

  create_table "contracts", force: true do |t|
    t.integer  "player_id"
    t.integer  "team_id"
    t.string   "year"
    t.decimal  "salary"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contracts", ["player_id"], name: "index_contracts_on_player_id", using: :btree
  add_index "contracts", ["team_id"], name: "index_contracts_on_team_id", using: :btree

  create_table "games", force: true do |t|
    t.datetime "game_date"
    t.string   "home_team"
    t.integer  "home_wins"
    t.integer  "home_losses"
    t.integer  "home_score"
    t.string   "away_team"
    t.integer  "away_wins"
    t.integer  "away_losses"
    t.integer  "away_score"
    t.integer  "attendance"
    t.string   "officials"
    t.boolean  "overtime"
    t.boolean  "playoff"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "bbr_gid"
  end

  create_table "players", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "abbr"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  limit: nil, default: "", null: false
    t.string   "encrypted_password",     limit: nil, default: "", null: false
    t.string   "reset_password_token",   limit: nil
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end

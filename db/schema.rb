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

ActiveRecord::Schema.define(version: 20150804195241) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "boxscores", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.string "player_name"
    t.integer "minutes"
    t.integer "seconds"
    t.decimal "fgm"
    t.decimal "fga"
    t.decimal "fg_pct"
    t.decimal "tpm"
    t.decimal "tpa"
    t.decimal "tp_pct"
    t.decimal "ftm"
    t.decimal "fta"
    t.decimal "ft_pct"
    t.decimal "orb"
    t.decimal "drb"
    t.decimal "trb"
    t.decimal "assists"
    t.decimal "steals"
    t.decimal "blocks"
    t.decimal "tov"
    t.decimal "pf"
    t.decimal "points"
    t.integer "plus_minus"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "game_id"
    t.integer "team_id"
    t.decimal "ts_pct"
    t.decimal "efg_pct"
    t.decimal "three_par"
    t.decimal "ftr"
    t.decimal "orb_pct"
    t.decimal "drb_pct"
    t.decimal "trb_pct"
    t.decimal "ast_pct"
    t.decimal "stl_pct"
    t.decimal "blk_pct"
    t.decimal "tov_pct"
    t.decimal "usg_pct"
    t.integer "o_rtg"
    t.integer "d_rtg"
    t.index ["game_id"], name: "index_boxscores_on_game_id"
    t.index ["player_id"], name: "index_boxscores_on_player_id"
    t.index ["team_id"], name: "index_boxscores_on_team_id"
  end

  create_table "contracts", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.integer "team_id"
    t.string "year"
    t.decimal "salary"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["player_id"], name: "index_contracts_on_player_id"
    t.index ["team_id"], name: "index_contracts_on_team_id"
  end

  create_table "games", id: :serial, force: :cascade do |t|
    t.datetime "game_date"
    t.integer "home_wins"
    t.integer "home_losses"
    t.integer "home_score"
    t.integer "away_wins"
    t.integer "away_losses"
    t.integer "away_score"
    t.integer "attendance"
    t.string "officials"
    t.boolean "overtime"
    t.boolean "playoff"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bbr_gid"
    t.integer "home_team_id"
    t.integer "away_team_id"
  end

  create_table "players", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "bbr_pid"
  end

  create_table "season_stats", id: :serial, force: :cascade do |t|
    t.integer "player_id"
    t.string "year"
    t.decimal "games"
    t.decimal "mp"
    t.decimal "per"
    t.decimal "ts_pct"
    t.decimal "three_par"
    t.decimal "ftr"
    t.decimal "orb_pct"
    t.decimal "drb_pct"
    t.decimal "trb_pct"
    t.decimal "ast_pct"
    t.decimal "stl_pct"
    t.decimal "blk_pct"
    t.decimal "tov_pct"
    t.decimal "usg_pct"
    t.decimal "ows"
    t.decimal "dws"
    t.decimal "ws"
    t.decimal "ws_48"
    t.decimal "obpm"
    t.decimal "dbpm"
    t.decimal "bpm"
    t.decimal "vorp"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "age"
    t.string "pos"
    t.index ["player_id"], name: "index_season_stats_on_player_id"
  end

  create_table "teams", id: :serial, force: :cascade do |t|
    t.string "abbr"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "boxscores", "games"
  add_foreign_key "boxscores", "teams"
end

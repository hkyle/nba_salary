class AddStatsTable < ActiveRecord::Migration
  def change

    create_table :advanced_stats do |t|
      t.belongs_to :player, index: true
      t.string :year
      t.decimal :games
      t.decimal :mp
      t.decimal :per
      t.decimal :ts_pct
      t.decimal :three_par
      t.decimal :ftr
      t.decimal :orb_pct
      t.decimal :drb_pct
      t.decimal :trb_pct
      t.decimal :ast_pct
      t.decimal :stl_pct
      t.decimal :blk_pct
      t.decimal :tov_pct
      t.decimal :usg_pct
      t.decimal :ows
      t.decimal :dws
      t.decimal :ws
      t.decimal :ws_48
      t.decimal :obpm
      t.decimal :dbpm
      t.decimal :bpm
      t.decimal :vorp

      t.timestamps
    end
  end
end

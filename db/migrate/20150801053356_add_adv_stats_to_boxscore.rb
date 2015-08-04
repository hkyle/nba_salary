class AddAdvStatsToBoxscore < ActiveRecord::Migration
  def change
    add_column :boxscores, :ts_pct, :decimal
    add_column :boxscores, :efg_pct, :decimal
    add_column :boxscores, :three_par, :decimal
    add_column :boxscores, :ftr, :decimal
    add_column :boxscores, :orb_pct, :decimal
    add_column :boxscores, :drb_pct, :decimal
    add_column :boxscores, :trb_pct, :decimal
    add_column :boxscores, :ast_pct, :decimal
    add_column :boxscores, :stl_pct, :decimal
    add_column :boxscores, :blk_pct, :decimal
    add_column :boxscores, :tov_pct, :decimal
    add_column :boxscores, :usg_pct, :decimal
    add_column :boxscores, :o_rtg, :integer
    add_column :boxscores, :d_rtg, :integer
  end
end

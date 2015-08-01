class ChangeAdvStatTableName < ActiveRecord::Migration
  def change
    rename_table :advanced_stats, :season_stats
  end
end

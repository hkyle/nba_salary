class ChangeAdvStatTableName < ActiveRecord::Migration[5.0]
  def change
    rename_table :advanced_stats, :season_stats
  end
end

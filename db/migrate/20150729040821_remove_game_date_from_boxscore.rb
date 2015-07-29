class RemoveGameDateFromBoxscore < ActiveRecord::Migration
  def change
    remove_column :boxscores, :game_date
  end
end

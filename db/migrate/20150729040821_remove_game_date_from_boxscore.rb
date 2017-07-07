class RemoveGameDateFromBoxscore < ActiveRecord::Migration[5.0]
  def change
    remove_column :boxscores, :game_date
  end
end

class RemoveTeamsAbbrFromGame < ActiveRecord::Migration[5.0]
  def change
    remove_column :games, :home_team
    remove_column :games, :away_team
  end
end

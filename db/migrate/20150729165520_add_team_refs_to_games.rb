class AddTeamRefsToGames < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :home_team_id, :integer
    add_column :games, :away_team_id, :integer
  end
end

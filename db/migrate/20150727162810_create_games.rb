class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.datetime :game_date
      t.string :home_team
      t.integer :home_wins
      t.integer :home_losses
      t.integer :home_score
      t.string :away_team
      t.integer :away_wins
      t.integer :away_losses
      t.integer :away_score
      t.integer :attendance
      t.string :officials
      t.boolean :overtime
      t.boolean :playoff
      
      t.timestamps
    end
  end
end

class CreateBoxscores < ActiveRecord::Migration
  def change
    create_table :boxscores do |t|
      t.belongs_to :player, index: true
      t.datetime :game_date
      t.string :player_name
      t.integer :minutes
      t.integer :seconds
      t.decimal :fgm
      t.decimal :fga
      t.decimal :fg_pct
      t.decimal :tpm
      t.decimal :tpa
      t.decimal :tp_pct
      t.decimal :ftm
      t.decimal :fta
      t.decimal :ft_pct
      t.decimal :orb
      t.decimal :drb
      t.decimal :trb
      t.decimal :assists
      t.decimal :steals
      t.decimal :blocks
      t.decimal :tov
      t.decimal :pf
      t.decimal :points
      t.integer :plus_minus
      
      t.timestamps
    end
  end
end

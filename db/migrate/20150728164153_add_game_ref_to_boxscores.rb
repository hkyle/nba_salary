class AddGameRefToBoxscores < ActiveRecord::Migration
  def change
    add_reference :boxscores, :game, index: true, foreign_key: true
  end
end

class AddGameRefToBoxscores < ActiveRecord::Migration[5.0]
  def change
    add_reference :boxscores, :game, index: true, foreign_key: true
  end
end

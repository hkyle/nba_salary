class AddTeamToBoxscores < ActiveRecord::Migration[5.0]
  def change
    add_reference :boxscores, :team, index: true, foreign_key: true
  end
end

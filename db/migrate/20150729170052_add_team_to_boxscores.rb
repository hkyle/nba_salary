class AddTeamToBoxscores < ActiveRecord::Migration
  def change
    add_reference :boxscores, :team, index: true, foreign_key: true
  end
end

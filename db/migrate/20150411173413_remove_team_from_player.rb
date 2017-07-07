class RemoveTeamFromPlayer < ActiveRecord::Migration[5.0]
  def change
    remove_column :players, :team
  end
end

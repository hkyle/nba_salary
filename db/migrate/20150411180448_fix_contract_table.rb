class FixContractTable < ActiveRecord::Migration[5.0]
  def change
    #previous migration created the team_id wrong, let's just fix it
    drop_table :contracts

    create_table :contracts do |t|
      t.belongs_to :player, index: true
      t.belongs_to :team, index: true
      t.string :year
      t.decimal :salary

      t.timestamps
    end
  end
end

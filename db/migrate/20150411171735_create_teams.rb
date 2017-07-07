class CreateTeams < ActiveRecord::Migration[5.0]
  def change
    create_table :teams do |t|
      t.string :abbr

      t.timestamps
    end
    
    change_table :contracts do |t|
      t.belongs_to :teams, index: true
    end
  end
end

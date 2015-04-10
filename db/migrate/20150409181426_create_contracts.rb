class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.belongs_to :player, index: true
      t.string :year
      t.decimal :salary

      t.timestamps
    end
  end
end

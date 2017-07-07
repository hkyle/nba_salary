class AddColumnsToStats < ActiveRecord::Migration[5.0]
  def change
    add_column :advanced_stats, :age, :integer
    add_column :advanced_stats, :pos, :string
  end
end

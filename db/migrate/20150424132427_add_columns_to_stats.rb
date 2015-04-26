class AddColumnsToStats < ActiveRecord::Migration
  def change
    add_column :advanced_stats, :age, :integer
    add_column :advanced_stats, :pos, :string
  end
end

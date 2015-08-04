class AddPlayerUrl < ActiveRecord::Migration
  def change
    add_column :players, :bbr_pid, :string
  end
end

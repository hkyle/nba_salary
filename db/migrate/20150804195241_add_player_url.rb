class AddPlayerUrl < ActiveRecord::Migration[5.0]
  def change
    add_column :players, :bbr_pid, :string
  end
end

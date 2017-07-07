class AddGameColumns < ActiveRecord::Migration[5.0]
  def change
    add_column :games, :bbr_gid, :string
  end
  
end

class AddGameColumns < ActiveRecord::Migration
  def change
    add_column :games, :bbr_gid, :string
  end
  
end

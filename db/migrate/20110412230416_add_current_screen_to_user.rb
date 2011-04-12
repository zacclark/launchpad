class AddCurrentScreenToUser < ActiveRecord::Migration
  def self.up
    add_column :users, :current_screen, :integer
  end

  def self.down
    remove_column :users, :current_screen
  end
end
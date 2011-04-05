class SwitchArchetypeToType < ActiveRecord::Migration
  def self.up
    rename_column :widgets, :archetype, :type
  end

  def self.down
    rename_column :widgets, :type, :archetype
  end
end
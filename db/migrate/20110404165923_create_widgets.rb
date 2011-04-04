class CreateWidgets < ActiveRecord::Migration
  def self.up
    create_table :widgets do |t|
      t.integer :user_id
      t.string :archetype
      t.string :data_runner_class
      t.text :serialized_settings
      t.text :serialized_current_data
      t.timestamps
    end
  end

  def self.down
    drop_table :widgets
  end
end

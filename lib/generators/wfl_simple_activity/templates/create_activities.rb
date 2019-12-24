# Migration responsible for creating a table with activities
class CreateActivities < ActiveRecord::Migration
  # Create table
  def self.up
    create_table :wfl_activities do |t|
      t.belongs_to :trackable, :polymorphic => true
      t.belongs_to :owner, :polymorphic => true
      t.string  :key
      t.text    :parameters
      t.belongs_to :recipient, :polymorphic => true
      t.text :model_changes
      t.integer :school_id
      t.string :description
      t.timestamps
    end

    add_index :wfl_activities, [:trackable_id, :trackable_type]
    add_index :wfl_activities, [:owner_id, :owner_type]
    add_index :wfl_activities, [:recipient_id, :recipient_type]
  end
  # Drop table
  def self.down
    drop_table :wfl_activities
  end
end

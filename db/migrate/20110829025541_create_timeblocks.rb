class CreateTimeblocks < ActiveRecord::Migration
  def self.up
    create_table :timeblocks do |t|
      t.datetime :start
      t.datetime :end
      t.text :note
      t.integer :user_id

      t.timestamps
    end
  end

  def self.down
    drop_table :timeblocks
  end
end

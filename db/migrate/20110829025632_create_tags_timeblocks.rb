class CreateTagsTimeblocks < ActiveRecord::Migration
  def self.up
    create_table :tags_timeblocks, :id => false do |t|
			t.integer :tag_id
			t.integer :timeblock_id
		end
  end

  def self.down
    drop_table :tags_timeblocks
  end
end

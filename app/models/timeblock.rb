class Timeblock < ActiveRecord::Base
  belongs_to :user
	has_and_belongs_to_many :tags
	
	validates_presence_of :user_id
	
	def tag_string
		tag_string = ""
		self.tags.each do |tag|
			tag_string += tag.name + ", "
		end
		if tag_string.end_with? ", "
			tag_string.slice! tag_string.length-2..tag_string.length
		end
		tag_string
	end
	
	def tag_string=(tag_string)
		user_id = self.user.id
		
		# remove all current tag associations
		self.tags.clear
				
		# parse string and add tag for each tag name
		tag_string.split(",").each do |tag_name|
			t = Tag.find_by_name_and_user_id(tag_name, user_id)
			if(t.nil?)
				t = Tag.create(:name => tag_name, :user_id => user_id)
			end
			self.tags << t
		end
		self.save
	end
end

class Timeblock < ActiveRecord::Base
  belongs_to :user
	has_and_belongs_to_many :tags
	
	validates_presence_of :user_id
	validates_presence_of :start
	
	MILLIS_PER_SECOND = 1000
	SECONDS_PER_MINUTE = 60
	MINUTES_PER_HOUR = 60
		
	def self.find_by_user_id_and_similar_date(id, date)
		self.where(:user_id => id, :start => date)
	end
	
	def self.find_all_by_user_id_and_date_range(id, start_date, end_date)
		self.where(:user_id => id, :start => start_date..end_date)
	end
	
	def tag_string
		tags.map(&:name).join(", ")
	end
	
	def tag_string=(tag_string)
		user_id = self.user.id
		
		# remove all current tag associations
		self.tags.clear
				
		# parse string and add tag for each tag name
		tag_string.split(",").each do |tag_name|
			t = Tag.find_or_create_by_name_and_user_id(tag_name.strip, user_id)
			self.tags << t
		end
		self.save
	end
	
	def durationInHours
		(self.end - self.start) / (SECONDS_PER_MINUTE * MINUTES_PER_HOUR)
	end
	
	def displayStartTime
		displayDateTime(self.start)
	end
	
	def displayEndTime
		displayDateTime(self.end)
	end
	
	private
	
	def displayDateTime(datetime)
		if(datetime)
			str = datetime.hour.to_s + ":" + datetime.min.to_s
			if(str.end_with? ':0')
				str += "0"
			else
				str
			end
		else
			""
		end
	end
end

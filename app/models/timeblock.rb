class Timeblock < ActiveRecord::Base
  belongs_to :user
	has_and_belongs_to_many :tags
	
	validates_presence_of :user_id
	validates_presence_of :start
	
	MILLIS_PER_SECOND = 1000
	SECONDS_PER_MINUTE = 60
	MINUTES_PER_HOUR = 60
		
	def self.find_by_user_id_and_similar_date(id, date)
		self.where("user_id = :user_id AND DATE(start) = :date",
													{:user_id => id, :date => date})
	end
	
	def self.find_all_by_user_id_and_date_range(id, start_date, end_date)
		self.where("user_id = :user_id AND DATE(start) >= :start_date AND DATE(start) <= :end_date",
								{:user_id => id, :start_date => start_date, :end_date => end_date})
	end
	
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
			tag_name = tag_name.strip
			t = Tag.find_or_create_by_name_and_user_id(tag_name, user_id)
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

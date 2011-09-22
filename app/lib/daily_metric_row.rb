class DailyMetricRow
	attr_accessor :tag_name, :total_hours
	
	def initialize(tag_name, total_hours)
		@tag_name = tag_name
		@total_hours = total_hours
	end
	
	def self.getDailyMetricRowsFromTimeblocks(timeblocks)
		tags = {}
		timeblocks.each do |timeblock|
			if(timeblock.end)
				timeblock.tags.each do |tag|
					if(tags[tag.name])
						dailyMetricRow = tags[tag.name]
						dailyMetricRow.total_hours = dailyMetricRow.total_hours + timeblock.durationInHours
					else
						d = DailyMetricRow.new(tag.name, timeblock.durationInHours)
						tags[tag.name] = d
					end
				end
			end
		end
		tags.values
	end
end

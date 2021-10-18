class Event < ApplicationRecord
	has_many :rsvps
	has_many :users, :through => :rsvps
	before_save :marked_as_completed

	def marked_as_completed
		completed = true if end_time < DateTime.now
	end
end

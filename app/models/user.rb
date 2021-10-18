class User < ApplicationRecord
	has_many :rsvps
	has_many :events, :through => :rsvps
	validates_uniqueness_of :username, :email
end

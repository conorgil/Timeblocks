class User < ActiveRecord::Base
	has_many :timeblocks
	
	validates_confirmation_of :password
	validates_uniqueness_of :email
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i
end

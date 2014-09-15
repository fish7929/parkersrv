require "securerandom"
class Event < ActiveRecord::Base
	before_create :generate_uuid



	private
	def generate_uuid
		self.uuid = SecureRandom.uuid
	end

end

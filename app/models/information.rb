require "securerandom"
class Information < ActiveRecord::Base
	has_many :tariffs
	before_create :generate_uuid
	



  private
	def generate_uuid
		self.uuid = SecureRandom.uuid
	end
end

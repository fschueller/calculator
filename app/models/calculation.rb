class Calculation < ActiveRecord::Base
	validates :equation, presence: true
	validates_format_of :equation, with: /\A[0-9\+\*\/\-\.\(\)]+\z/ # prevents from entering invalid stuff
	before_save :calculate

	def calculate
		self.result = eval self.equation
	end
end

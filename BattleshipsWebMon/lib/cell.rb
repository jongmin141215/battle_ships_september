class Cell
	attr_accessor :content
	attr_reader :hit
	def initialize
		@hit = false
	end

	def shoot
		@hit = content.hit!
	end

	def hit?
		@hit
	end
end

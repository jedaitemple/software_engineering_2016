class Widget < ActiveRecord::Base
	def update
		self.count += 1
		self.save
	end
end

class WareHouse
	@@uninspected_cars = []

	def self.set_uninspected_cars
		@@uninspected_cars = Car.where( :storage => [ nil, 0 ] )
	end

	def self.get_uninspected_cars
		return Car.where( :storage => [ nil, 0 ] )
	end

	def self.get_rejected_cars
		return Car.where( :storage => 1 )
	end

	def self.get_ready_to_sell_cars
		return Car.where( :storage => 2 )
	end

		


	
end
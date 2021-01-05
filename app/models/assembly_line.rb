class AssemblyLine
	@@cars = []

	def self.add_car_to_line car
		@@cars.push( car )
	end

	def self.remove_car_rom_line car
		@@cars.delete( car )
	end

	def self.process_cars
	end
end
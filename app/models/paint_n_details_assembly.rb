class PaintNDetailsAssembly < AssemblyLine
	
	def self.process_cars
		@@cars.each do | car |
			self.add_seats( car )
			self.paint( car )
			self.set_car_as_uninspected( car )
			car.save
		end
	end

	def self.add_seats car
		seats_amount = 2
		seats_amount.times do |seat|
			seat = ApplicationController.helpers.get_car_part( "seat", "Seat Brand" )
			seat.update( :car => car  )
		end
	end

	def self.paint car
		color = "#%02X%02X%02X" % [rand(1..255), rand(1..255), rand(1..255)] # create a random hexadecimal hash for web color
		car.update( color:color )
	end

	def self.set_car_as_uninspected car
		car.update( storage:0 )
	end

end
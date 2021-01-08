class PaintNDetailsAssembly < AssemblyLine

	def self.process_cars
		@@cars.each do | car | 
			self.add_seats( car )
			self.paint( car )
			self.set_car_as_uninspected( car )
			self.remove_car_from_line( car )
		end
	end

	def self.add_seats car
		seats_amount = 2
		probability = 3							# average defectiveness
		defective = rand(1..100) < probability  # this line gives a probability of defective part creation
		seats_amount.times { seat = Seat.create( brand:"Seat Brand", serial_number:Time.now.to_i, defective_part:defective, car:car ) }
	end

	def self.paint car
		color = "#%02X%02X%02X" % [rand(1..255), rand(1..255), rand(1..255)] # create a random hexadecimal hash for web color
		car.update( color:color )
	end

	def self.set_car_as_uninspected car
		car.update( storage:0 )
	end

end
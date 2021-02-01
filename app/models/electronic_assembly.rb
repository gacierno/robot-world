class ElectronicAssembly < AssemblyLine

	def self.process_cars
		@@cars.each do | car | 
			self.add_laser( car )
			self.add_computer( car )
			car.save
		end
	end

	def self.add_laser car
		laser = ApplicationController.helpers.get_car_part( "laser", "Laser Brand" )
		laser.update( :car => car  )
	end

	def self.add_computer car
		computer = ApplicationController.helpers.get_car_part( "computer", "Computer Brand" )
		computer.update( :car => car  )
	end

end
class BasicAssembly < AssemblyLine

	def self.process_cars 
		@@cars.each do | car |
			self.add_chassis( car )
			self.add_engine( car )
			self.add_wheels( car )
			car.save
		end
	end

	def self.add_chassis car
		chassis = ApplicationController.helpers.get_car_part( "chassis", "Chasis Brand" )
		chassis.update( :car => car  )
	end

	def self.add_engine car
		engine = ApplicationController.helpers.get_car_part( "engine", "Engine Brand" )
		engine.update( :car => car  )
	end

	def self.add_wheels car
		wheels_amount = 4
		wheels_amount.times do |wheel| 
			wheel = ApplicationController.helpers.get_car_part( "wheel", "Wheel Brand" )
			wheel.update( :car => car  )
		end
	end

end
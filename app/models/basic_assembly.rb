class BasicAssembly < AssemblyLine

	def self.process_cars
		@@cars.each do | car | 
			self.add_chassis( car )
			self.add_engine( car )
			self.add_wheels( car )
		end
	end

	def self.add_chassis car
		probability = 15						# average defectiveness
		defective = rand(1..100) < probability  # this line gives a probability of defective part creation
		chassis = Chassis.create( brand:"Chassis Brand", serial_number:Time.now.to_i, defective_part:defective, car:car )
	end

	def self.add_engine car
		probability = 5							# average defectiveness
		defective = rand(1..100) < probability  # this line gives a probability of defective part creation
		engine = Engine.create( brand:"Motor Brand", serial_number:Time.now.to_i, defective_part:defective, car:car )
	end

	def self.add_wheels car
		wheels_amount = 4
		probability = 3							# average defectiveness
		defective = rand(1..100) < probability  # this line gives a probability of defective part creation
		wheels_amount.times { wheel = Wheel.create( brand:"Wheel Brand", serial_number:Time.now.to_i, defective_part:defective, car:car ) }
	end

end
class ElectronicAssembly < AssemblyLine

	def self.process_cars
		@@cars.each do | car | 
			self.add_laser( car )
			self.add_computer( car )
			car.save
		end
	end

	def self.add_laser car
		probability = 15						# average defectiveness
		defective = rand(1..100) < probability  # this line gives a probability of defective part creation
		laser = Laser.create( brand:"Laser Brand", serial_number:Time.now.to_i, defective_part:defective, car:car )
	end

	def self.add_computer car
		probability = 5							# average defectiveness
		defective = rand(1..100) < probability  # this line gives a probability of defective part creation
		computer = Computer.create( brand:"Computer Brand", serial_number:Time.now.to_i, defective_part:defective, car:car )
	end

end
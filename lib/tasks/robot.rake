namespace :robot do

	desc 'Robots Tasks'
	

	# This task will be executed every minute by robot builder to create new cars
	task :builder => :environment do
		qty_to_build = 10

		qty_to_build.times do
			model = rand( 1..10 ) #select a model id betwen 1 to 10
			c = Car.new( model_id:model, price:125, cost_price:100)
			c.save

			puts "Working on car number : " + c.id.to_s

			BasicAssembly.add_car_to_line( c )
			BasicAssembly.process_cars

			ElectronicAssembly.add_car_to_line( c )
			ElectronicAssembly.process_cars

			PaintNDetailsAssembly.add_car_to_line( c )
			PaintNDetailsAssembly.process_cars
		end
	end




	namespace :guard do
		
		# This task will be executed every minute by robot guard to reject cars with defects
		task :inspect_cars => :environment do

			# Inspect the cars at the warehouse
			uninspected_cars = WareHouse.get_uninspected_cars

			uninspected_cars.each do |car|
				if car.check_computer == -1 then  	# it means that the car isn't finished
					car.update( storage:nil )		# send it back to "in_progress"

				elsif car.check_computer == 0 then	# it means the car passed the test
					car.update( storage:2 )  # putting storage == 2 instead of 3 to simulate 2 different stocks (warehouse and saleroom)
				
				else
					car.update( storage:1 )			# it means the car has at least 1 defect
					# send_car data to slack
				end
			end
			uninspected_cars = []	# empty array to save memory
			puts "tested cars"

		end

		# This task will be executed every 30 minutes by robot guard to move approved cars to store stock
		task :move_cars => :environment do
			# Move aproved cars to salesroom
			approved_cars = WareHouse.get_approved_cars

			approved_cars.each do |car| 
				car.update( storage:3 )
			end

			approved_cars = []	# empty array to save memory
			puts "moved cars"

		end
	end




	# This task will be executed every minute by robot buyer to buy cars from store stcok
	task :buyer => :environment do

		robot_buyer_id = 1001 	#this is a hardcodded id for this robot, it can become a customer id
		
		max_cars_allowed_to_buy = 10
		qty_to_buy = rand(1..max_cars_allowed_to_buy)

		qty_to_buy.times do
			model_to_buy = rand(1..10)
			car_to_buy = SalesRoom.get_a_car_by_model_id model_to_buy

			if car_to_buy != nil
				# if the car exists robot will buy it
				SalesRoom.create_order car_to_buy, robot_buyer_id
				puts "Car buyed " + car_to_buy.model.name
			else
				mod = Model.where( :id => model_to_buy ).first
				puts "Robot buyer id=" + robot_buyer_id.to_s + " tryed to buy a " + mod.name + " but there wasn't any on stock" 
			end

		end
	end


end












namespace :robot do

	desc 'Robots Tasks'

	namespace :builder do
		# This task will be executed every minute by robot builder to create new cars
		task :start => :environment do
			qty_to_build = 10

			qty_to_build.times do
				models_qty = Model.all.count
				model = Model.all[ rand( 0...models_qty ) ] #select a model id in the model list
				c = Car.create( model:model )
				BasicAssembly.add_car_to_line( c )
			end
		
			BasicAssembly.process_cars
		
			ElectronicAssembly.process_cars
		
			PaintNDetailsAssembly.process_cars

			BasicAssembly.drop_lines

		end

		# This task will be executed every day by robot builder to clean factory and strat from scratch
		task :cleanup => :environment do
			# Calling drop_lines fom any of the assembly lines is enought because @@cars is a Class Attribute (static)
			# BasicAssembly.drop_lines

			# As rails works with actvie records it's difficult to drop the assembly lines because these cars are already saved on DB 
		end
	end



	namespace :guard do
		
		# This task will be executed every minute by robot guard to reject cars with defects
		task :inspect_cars => :environment do

			# Set Slack 'notifier' instance to send data to reviewers
			notifier = Slack::Notifier.new "https://hooks.slack.com/services/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"

			# Inspect the cars at the warehouse
			uninspected_cars = WareHouse.get_uninspected_cars

			uninspected_cars.each do |car|
				if car.check_computer == -1 then  	# it means that the car isn't finished
					car.update( storage:nil )		# send it back to "in_progress"

				elsif car.check_computer == 0 then	# it means the car passed the test
					car.update( storage:2 )  # putting storage == 2 instead of 3 to simulate 2 different stocks (warehouse and saleroom)
				
				else
					car.update( storage:1 )			# it means the car has at least 1 defect

					reject_message = "BUILDER  | => The car " + car.to_json + "has defects"		

					puts reject_message
					# send_car data to slack
					# notifier.ping reject_message

				end
			end
			uninspected_cars = []	# empty array to save memory
			# puts "tested cars"

		end

		# This task will be executed every 30 minutes by robot guard to move approved cars to store stock
		task :move_cars => :environment do
			# Move aproved cars to salesroom
			approved_cars = WareHouse.get_approved_cars

			approved_cars.each do |car| 
				car.update( storage:3 )
			end

			approved_cars = []	# empty array to save memory
			# puts "moved cars"

		end
	end



	namespace :buyer do


		# This task will be executed every minute by robot buyer to buy cars from store stcok
		task :buy_cars => :environment do

			robot_buyer_id = 1001 	#this is a hardcodded id for this robot, it can become a customer id
			
			max_cars_allowed_to_buy = 10
			qty_to_buy = rand(1..max_cars_allowed_to_buy)

			qty_to_buy.times do
				model_to_buy = rand(1..10)
				car_to_buy = SalesRoom.get_a_car_by_model_id model_to_buy

				if car_to_buy != nil
					# if the car exists robot will buy it
					SalesRoom.create_order car_to_buy, robot_buyer_id
					# puts "Car buyed " + car_to_buy.model.name
				else
					mod = Model.where( :id => model_to_buy ).first
					puts "BUY      | At "+ Time.now.to_s + " Robot buyer id=" + robot_buyer_id.to_s + " tryed to buy a " + mod.name + " but there wasn't any on stock" 

					# Search the car on factory stock
					car_to_reserve = Car.by_model_id( model_to_buy ).approved.not_reserved.first

					if car_to_reserve != nil
						SalesRoom.create_reservation car_to_reserve, robot_buyer_id
					end

				end

			end
		end

		task :ask_for_a_car_change => :environment do

			robot_buyer_id = 1001 	#this is a hardcodded id for this robot, it can become a customer id
			
			how_many_changes = rand( 0..5 )

			how_many_changes.times do
				puts "CHANGE   | Asking for a change"
				# get a buyed car that will be changed
				car_to_be_changed = Car.sold[ rand( 0...Car.sold.count ) ]

				# get a diferent model from the car that is being changed
				begin
					new_model = rand(1..10)
				end while new_model == car_to_be_changed.model_id

				#get current car order
				order_to_be_canceled = Order.where( car_id:car_to_be_changed.id ).first

				new_car = SalesRoom.get_a_car_by_model_id new_model

				if new_car != nil # there is a car abailable for change
					
					#cancel the old order
					change_order = ChangeOrder.new order:order_to_be_canceled
					change_order.save
					
					#set the car ready for sale
					car_to_be_changed.storage = 3

					# buy the new car
					SalesRoom.create_order new_car, robot_buyer_id

					puts "CHANGE   | Car #{car_to_be_changed.id} changed by Car #{new_car.id}"
				else
					# if there isn't any car of the required model system will look for it on factory stock
					car_to_reserve = Car.by_model_id( new_model ).approved.not_reserved.first

					if car_to_reserve != nil # there is a car of this model on factory stock

						#cancel the old order
						change_order = ChangeOrder.new order:order_to_be_canceled
						change_order.save
						#set the car ready for sale
						car_to_be_changed.storage = 3
						#reserve the new car
						SalesRoom.create_reservation car_to_reserve, robot_buyer_id
						puts "CHANGE   | Car #{car_to_be_changed.id} changed by Car #{car_to_reserve.id}"
					else
						puts "CHANGE   | No car was changed"
					end

				end

			end
		end


	end
	


	task :car_delivery => :environment do

		reservations = Reservation.pending

		reservations.each do |res|
			reserved_car = Car.find( res.car_id )
			if reserved_car.storage == 3 # means it is on store
				SalesRoom.create_order reserved_car, res.buyer
				res.update( delivered:true )
			end
		end 
	end





	task :execs => :environment do

		orders = Order.from_yesterday
		change_orders = ChangeOrder.from_yesterday

		#calculate incomes
		revenue = 0
		orders.each do |item|
			revenue += item.order_car_price
		end
		change_orders.each do |item|
			revenue -= item.order.order_car_price
		end

		#calculate how many cars were sold
		sold_cars = orders.count - change_orders.count

		#calculate average (avoid divide by 0)
		if sold_cars != 0 && sold_cars != nil
			average = revenue/sold_cars
		else
			average = 0
		end

		puts "EXECS    | "+Date.yesterday.to_s
		puts "EXECS    | Revenue = "+revenue.to_s
		puts "EXECS    | Sold Cars = "+sold_cars.to_s
		puts "EXECS    | Average Price = "+average.to_s

	end

	task :repairer => :environment do

		cars_to_repair = Car.rejected

		cars_to_repair.each do | item_car |

			parts_to_repair = item_car.get_defective_parts

			parts_to_repair.each do | item_part |
			
				# assume all parts can be repaired
				# if it was not the case it is possible to put some code to represent this behavior
				item_part.update( defective_part:false )
			
			end

			item_car.update( storage:0 )

			puts "REPAIRER | Tha Car "+item_car.to_s+" has been repaired"
				 
		end
	end


end










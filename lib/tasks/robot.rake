namespace :robot do
	desc 'Start Building'
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
end


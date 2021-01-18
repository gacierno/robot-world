namespace :dataload do
	desc 'It loads data to DB and Static Classes'


	## LOAD CAR MODELS TO DATABASE IF IT IS EMPTY ON INIT
	task :models => :environment do
		mods = Model.all
		if mods.empty?
			Model.create( name:"Corvette", price:200000, cost_price:100000 )
			Model.create(name:"Bell Air", price:180000, cost_price:90000 )
			Model.create(name:"Nova", price:160000, cost_price:80000)
			Model.create(name:"El Camino", price:140000, cost_price:70000)
			Model.create(name:"Stingray", price:120000, cost_price:60000)
			Model.create(name:"Monte Carlo", price:100000, cost_price:50000)
			Model.create(name:"Camaro", price:90000, cost_price:45000)
			Model.create(name:"Impala", price:80000, cost_price:40000)
			Model.create(name:"Corvair", price:70000, cost_price:35000)
			Model.create(name:"Chevelle", price:60000, cost_price:30000)
		end
	end


end
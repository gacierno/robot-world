namespace :dataload do
	desc 'It loads data to DB and Static Classes'


	## LOAD CAR MODELS TO DATABASE IF IT IS EMPTY ON INIT
	task :models => :environment do
		mods = Model.all
		if mods.empty?
			Model.create(name:"Corvette")
			Model.create(name:"Bell Air")
			Model.create(name:"Nova")
			Model.create(name:"El Camino")
			Model.create(name:"Stingray")
			Model.create(name:"Monte Carlo")
			Model.create(name:"Camaro")
			Model.create(name:"Impala")
			Model.create(name:"Corvair")
			Model.create(name:"Chevelle")
		end
	end


end
class SalesRoom

	def self.get_a_car_by_model_name name
		return Car.by_model_name( model ).on_sale.first
	end

	def self.get_a_car_by_model_id id
		return Car.by_model_id( id ).on_sale.first
	end

	def self.create_order car, buyer_id
		if car != nil && car.storage == 3 && buyer_id != nil	# storage == 3 means the car is for sale
			car.update( storage:4 )
			Order.create( car:car, buyer:buyer_id )
		end
	end

	def self.get_orders
		Order.all
	end

end
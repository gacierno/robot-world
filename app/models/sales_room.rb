class SalesRoom

	def self.get_a_car_by_model_name name
		# also check the car isn't reserved
		return Car.by_model_name( model ).on_sale.not_reserved.first
	end

	def self.get_a_car_by_model_id id
		# also check the car isn't reserved
		return Car.by_model_id( id ).on_sale.not_reserved.first
	end

	def self.create_order car, buyer_id
		if car != nil && car.storage == 3 && buyer_id != nil	# storage == 3 means the car is for sale
			car.update( storage:4 )
			Order.create( car:car, buyer:buyer_id, order_car_price:car.model.price, order_car_cost:car.model.cost_price )
		end
	end

	def self.create_reservation car, buyer_id
		if car != nil && car.storage == 2 && buyer_id != nil	# storage == 2 means the car is approved on factory stock
			res = Reservation.create( car:car, buyer:buyer_id, delivered:false )
			puts "  => System Reserved a Car for client : "+ buyer_id.to_s+" at reservation : "+ res.id.to_s
		end
	end

	def self.get_orders
		Order.all
	end

end
class SalesRoom

	def self.get_a_car_by_model_name name
		# also check the car isn't reserved
		Car.by_model_name( model ).on_sale.not_reserved.first
	end

	def self.get_a_car_by_model_id id
		# also check the car isn't reserved
		Car.by_model_id( id ).on_sale.not_reserved.first
	end

	def self.create_order car, buyer_id
		unless car.blank? || car.storage != "on sale" || buyer_id.blank?
			car.update( storage:"sold" )
			Order.create( car:car, buyer:buyer_id, order_car_price:car.model.price, order_car_cost:car.model.cost_price )
		end
	end

	def self.create_reservation car, buyer_id
		unless car.blank? || car.storage != "approved" || buyer_id.blank?
			res = Reservation.create( car:car, buyer:buyer_id, delivered:false )
			puts "  => System Reserved a Car for client : "+ buyer_id.to_s+" at reservation : "+ res.id.to_s
		end
	end

	def self.get_orders
		Order.all
	end

end
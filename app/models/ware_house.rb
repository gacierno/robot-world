class WareHouse

	def self.get_uninspected_cars
		Car.uninspected
	end

	def self.get_rejected_cars
		Car.rejected
	end

	def self.get_approved_cars
		Car.approved
	end

	def self.get_stock_by_model_name model
		Car.by_model_name( model ).approved
	end
end
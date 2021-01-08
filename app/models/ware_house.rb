class WareHouse

	def self.get_uninspected_cars
		return Car.uninspected
	end

	def self.get_rejected_cars
		return Car.rejected
	end

	def self.get_approved_cars
		return Car.approved
	end

	def self.get_stock_by_model_name model
		return Car.by_model_name( model ).approved
	end
end
class Car < ApplicationRecord

	# references
	has_many :car_parts
	belongs_to :model

	has_one :reservation

	# scopes
	scope :in_progress, -> { where( :storage => nil ) }
	scope :uninspected, -> { where( :storage => 0 ) }
	scope :rejected, -> { where( :storage => 1 ) }
	scope :approved, -> { where( :storage => 2 ) }
	scope :on_sale, -> { where( :storage => 3 ) }
	scope :sold, -> { where( :storage => 4 ) }

	scope :by_model_name, -> ( _model ) { joins(:model).where( "models.name = ?", _model ) }
	scope :by_model_id, -> ( _id ) { where( "model_id = ?", _id ) }

	# as we have reservations system will need to know if thew car is reserved to be sure about no to sell a reserved car or reserve it twice 
	scope :not_reserved, -> { joins("LEFT JOIN reservations ON cars.id = reservations.car_id").where( "reservations.id IS ?", nil ) }

	# validations
	validates_associated :model

	def reserved
		if reservation == nil || reservation.delivered == true
			return false
		else
			return true
		end
	end

	def year
		created_at.year
	end

	def check_computer
		# if check_car_build_stage >= 3
		# 	defective_parts = 0
		# 	defective_parts += wheels.where( defective_part:true ).count
		# 	defective_parts += seats.where( defective_part:true ).count
		# 	defective_parts += chassis.defective_part ? 1 : 0
		# 	defective_parts += laser.defective_part ? 1 : 0
		# 	defective_parts += engine.defective_part ? 1 : 0
		# 	defective_parts += computer.defective_part ? 1 : 0
		# else
		# 	-1
		# end
	end

	def check_car_build_stage

		# if seats.count == 2 && color != nil then
		# 	status = 3
		# elsif laser != nil && computer != nil then
		# 	status = 2
		# elsif wheels.count == 4 && chassis != nil && engine != nil then
		# 	status = 1
		# else
		# 	status = 0
		# end
	
		# return	status

	end

	def get_defective_parts
		# defective_parts = []
		# defective_parts << wheels.where( defective_part:true )
		# defective_parts << seats.where( defective_part:true )
		# if chassis.defective_part
		# 	defective_parts << chassis
		# end
		# if laser.defective_part
		# 	defective_parts << laser
		# end
		# if engine.defective_part
		# 	defective_parts << engine
		# end
		# if computer.defective_part
		# 	defective_parts << computer
		# end
		# return defective_parts
	end

end

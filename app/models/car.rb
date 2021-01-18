class Car < ApplicationRecord

	has_many :wheels
	has_many :seats
	has_one :chassis
	has_one :laser
	has_one :engine
	has_one :computer
	belongs_to :model

	scope :in_progress, -> { where( :storage => nil ) }
	scope :uninspected, -> { where( :storage => 0 ) }
	scope :rejected, -> { where( :storage => 1 ) }
	scope :approved, -> { where( :storage => 2 ) }
	scope :on_sale, -> { where( :storage => 3 ) }
	scope :sold, -> { where( :storage => 4 ) }

	scope :by_model_name, -> ( _model ) { joins(:model).where( "models.name = ?", _model ) }
	scope :by_model_id, -> ( _id ) { where( "model_id = ?", _id ) }

	def year
		created_at.year
	end

	def check_computer
		if check_car_build_stage >= 3
			defective_parts = 0
			defective_parts += wheels.where( defective_part:true ).count
			defective_parts += seats.where( defective_part:true ).count
			defective_parts += chassis.defective_part ? 1 : 0
			defective_parts += laser.defective_part ? 1 : 0
			defective_parts += engine.defective_part ? 1 : 0
			defective_parts += computer.defective_part ? 1 : 0
		else
			-1
		end
	end

	def check_car_build_stage

		if seats.count == 2 && color != nil then
			status = 3
		elsif laser != nil && computer != nil then
			status = 2
		elsif wheels.count == 4 && chassis != nil && engine != nil then
			status = 1
		else
			status = 0
		end
	
		return	status

	end
end

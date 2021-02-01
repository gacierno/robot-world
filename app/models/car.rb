class Car < ApplicationRecord

	# references
	has_many :car_parts
	belongs_to :model

	has_one :reservation

	# scopes
	scope :in_progress, -> { where( :storage => nil ) }
	scope :uninspected, -> { where( :storage => "uninspected" ) }
	scope :rejected, -> { where( :storage => "rejected" ) }
	scope :approved, -> { where( :storage => "approved" ) }
	scope :on_sale, -> { where( :storage => "on sale" ) }
	scope :sold, -> { where( :storage => "sold" ) }
	scope :in_transit, -> { where( :storage => "in transit" ) }

	scope :by_model_name, -> ( _model ) { joins(:model).where( "models.name = ?", _model ) }
	scope :by_model_id, -> ( _id ) { where( "model_id = ?", _id ) }

	# as we have reservations system will need to know if thew car is reserved to be sure about no to sell a reserved car or reserve it twice 
	scope :not_reserved, -> { joins("LEFT JOIN reservations ON cars.id = reservations.car_id").where( "reservations.id IS ?", nil ) }

	# validations
	validates_associated :model

	def reserved
		if reservation.blank? || reservation.delivered?
			false
		else
			true
		end
	end

	def year
		created_at.year
	end

	def check_computer
		defective_parts = []
		car_parts.each do |part|
			if part.defective_part?
				defective_parts << part
			end
		end
		defective_parts
	end



end

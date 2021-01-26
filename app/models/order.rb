class Order < ApplicationRecord
	#references
	belongs_to :car

	#scoped queries
	scope :from_yesterday, -> { where( "DATE(created_at) = ?", Date.yesterday ) }

	#validations
	validates :car, :buyer, presence: true, on: :create
	validates :buyer, numericality: { only_integer:true, greater_than:0 }
	validates_associated :car
end

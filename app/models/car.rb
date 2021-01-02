class Car < ApplicationRecord
	has_many :wheels
	has_many :seats
	has_one :chasis
	has_one :laser
	has_one :engine
	has_one :computer
	belongs_to :model
end

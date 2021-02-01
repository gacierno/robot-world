class Reservation < ApplicationRecord
	#references
	belongs_to :car
	
	#scoped queries
	scope :pending, -> { where( delivered:false ) }

	#validations

	validates :car, presence: true, :on => :create
	validates :buyer, presence: true, :on => :create

	validates :delivered, inclusion: [ false, true ], on: :create # a reservation can not be created as delivered
	validates_associated :car


	

end

class Reservation < ApplicationRecord
	#references
	belongs_to :car
	
	#scoped queries
	scope :pending, -> { where( delivered:false ) }

	#validations
	validates :car, :buyer, presence: true, on: :create
	validates :delivered, inclusion: [ false ], on: :create # a reservation can not be created as delivered
	validates_associated :car

	validates :delivered, inclusion: [ true ], on: :update # a reservation only can be changed to delivered
	validates :car, :buyer, presence: false, on: :update # a car can not be changed on updates


end

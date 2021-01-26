class Model < ApplicationRecord

	validates :name, :price, :cost_price, presence: true, on: :create
	validates :name, uniqueness: true
	validates :price, numericality: { greater_than: 0 }
	validates :cost_price, numericality: { greater_than: 0, less_than: :price }
	
end

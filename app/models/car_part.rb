class CarPart < ApplicationRecord
  belongs_to :car

  validates :brand, :serial_number, :defective_part, :type, presence: true, on: :create
  validates :serial_number, numericality: { only_integer:true , greater_than:100000 }
  validates_associated :car

end


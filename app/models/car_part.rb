class CarPart < ApplicationRecord
  belongs_to :car, optional: true 

  validates :brand, :serial_number, :part_name, presence: true, on: :create
  validates :defective_part, inclusion: [true, false]
  validates :serial_number, numericality: { only_integer:true , greater_than:100000 }
  validates_associated :car

end


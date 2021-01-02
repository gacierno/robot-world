class AddCarReferenceToCarParts < ActiveRecord::Migration[5.2]
  def change
  	add_reference :car_parts, :car, references: :foreign_key
  end
end

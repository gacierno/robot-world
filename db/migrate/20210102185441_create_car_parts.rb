class CreateCarParts < ActiveRecord::Migration[5.2]
  def change
    create_table :car_parts do |t|
      t.string :brand
      t.boolean :defective_part
      t.integer :serial_number

      t.timestamps
    end
  end
end

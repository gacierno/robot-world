class ChangeHeritanceForPartNameOnCarParts < ActiveRecord::Migration[5.2]
  def change
  	remove_column :car_parts, :type, :string
  	add_column :car_parts, :part_name, :string
  end
end

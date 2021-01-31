class RemoveYearFromCar < ActiveRecord::Migration[5.2]
  def change
  	remove_column :cars, :year, :integer
  end
end

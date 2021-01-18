class MovePricesFromCarsToModels < ActiveRecord::Migration[5.2]
  def change
  	remove_column :cars, :price, :float
  	remove_column :cars, :cost_price, :float
  	add_column :models, :price, :float
  	add_column :models, :cost_price, :float
  end
end

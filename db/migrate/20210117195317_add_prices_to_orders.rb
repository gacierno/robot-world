class AddPricesToOrders < ActiveRecord::Migration[5.2]
  def change
  	# Adding prices to orders in case the car prices change its price 
  	# the order must represent the value of the transaction at the momet it took place
  	add_column :orders, :order_car_price, :float
  	add_column :orders, :order_car_cost, :float
  end
end

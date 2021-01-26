require "rails_helper"

RSpec.describe "Creation of an order" do

	car = Car.new( model_id:1 )
	test_order = Order.new( car:car, buyer:1, order_car_price:car.model.price, order_car_cost:car.model.cost_price )
	it "is valid with valid attributes" do	
		expect( test_order ).to be_valid
	end
end
require "rails_helper"

RSpec.describe "Creation of a change order" do

	car = Car.new( model_id:1 )
	order = Order.new( car:car, buyer:1, order_car_price:car.model.price, order_car_cost:car.model.cost_price )
	test_change = ChangeOrder.new( order:order )

	it "is valid with valid attributes" do	
		expect( test_change ).to be_valid
	end
	
end
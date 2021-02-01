require "rails_helper"

RSpec.describe "Creation of an order" do

	it "is valid with valid attributes" do	

		model_test = Model.create( name:"Test Model", price:200000, cost_price:100000 )
		car = Car.create( model:model_test )
		test_order = Order.create( car:car, buyer:1, order_car_price:car.model.price, order_car_cost:car.model.cost_price )
		expect( test_order ).to be_valid

	end
end
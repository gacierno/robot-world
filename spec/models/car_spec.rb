require "rails_helper"

RSpec.describe "Creation of a Car" do

	it "is valid with valid attributes" do
		model_test = Model.create( name:"Test Model", price:200000, cost_price:100000 )
		test_car = Car.new( :model => model_test )
		expect( test_car ).to be_valid
	end

end
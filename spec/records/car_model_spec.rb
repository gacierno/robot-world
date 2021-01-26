require "rails_helper"

RSpec.describe "Creation of a Car" do

	model_test = Model.first
	test_car = Car.new( :model => model_test )

	it "is valid with valid attributes" do	
		expect( test_car ).to be_valid
	end

end
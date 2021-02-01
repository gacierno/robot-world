require "rails_helper"

RSpec.describe Reservation do

	it "is valid with valid attributes" do
		model_test = Model.create( name:"Test Model", price:200000, cost_price:100000 )
		car = Car.create( model:model_test )
		test_reservation1 = Reservation.create( car:car, buyer:1, delivered:false )
		expect( test_reservation1 ).to be_valid
	end

end

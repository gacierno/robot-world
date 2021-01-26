require "rails_helper"

RSpec.describe Reservation do

	car = Car.new( model_id:1 )
	test_reservation = Reservation.new( car:car, buyer:1, delivered:false )

	it "is valid with valid attributes" do	
		expect( test_reservation ).to be_valid
	end

	it "can not change car on updates" do
		other_car = Car.new( model_id:1 )
		test_reservation.update( car:other_car )
		expect( test_reservation ).to_not be_valid
	end

	it "can not change buyer on updates" do
		test_reservation = Reservation.new( car:car, buyer:1, delivered:false )
		test_reservation.update( buyer:3 )
		expect( test_reservation ).to_not be_valid
	end

end

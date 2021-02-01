require "rails_helper"

RSpec.describe "Creation of a Car part" do

	it "is valid with valid attributes" do
		car_part = CarPart.create( :part_name => "Test Name", :brand => "Test", :serial_number => Time.now.to_i, :defective_part => true )	
		expect( car_part ).to be_valid
	end

end
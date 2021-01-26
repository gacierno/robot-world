require "rails_helper"

RSpec.describe Model do

	it "must have a unique name" do	
		Model.create( name:"unique model name", price:200000, cost_price:100000 )
		test_model = Model.new( name:"unique model name", price:200000, cost_price:100000 )
		expect( test_model ).to_not be_valid
	end

	it "has valid attributes" do	
		test_model = Model.new( name:"Testeable name", price:200000, cost_price:100000 )
		expect( test_model ).to be_valid
	end
end
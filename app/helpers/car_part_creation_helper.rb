module CarPartCreationHelper
	def get_car_part( p_name, p_brand, p_defectiveness_ratio = 5 )
		defective = rand(1..100) < p_defectiveness_ratio  # this line gives a probability of defective part creation
    	CarPart.create( :brand => p_brand, :part_name => p_name, :serial_number => Time.now.to_i, :defective_part => defective )
	end
end
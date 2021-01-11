class AddBuyerToOrders < ActiveRecord::Migration[5.2]
  def change
    add_column :orders, :buyer, :integer	# for this systems the buyer field is the id that belongs to robot buyer
    										# it can become a customer reference in the future
  end
end

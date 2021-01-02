class AddModelReferenceeToCar < ActiveRecord::Migration[5.2]
  def change
  	add_reference :cars, :model, references: :foreign_key
  end
end

class ConvertStorageToString < ActiveRecord::Migration[5.2]
  def change
  	change_column :cars, :storage, :string
  end
end

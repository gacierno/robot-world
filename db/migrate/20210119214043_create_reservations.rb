class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.references :car, foreign_key: true
      t.boolean :delivered
      t.integer :buyer

      t.timestamps
    end
  end
end

class CreateReservations < ActiveRecord::Migration[5.0]
  def change
    create_table :reservations do |t|
      t.integer :resid
      t.integer :gid
      t.datetime :reservationtime
      t.integer :gcount
      t.string :bookingstat

      t.timestamps
    end
  end
end

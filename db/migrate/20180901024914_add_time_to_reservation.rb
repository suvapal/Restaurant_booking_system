class AddTimeToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :time, :time
  end
end

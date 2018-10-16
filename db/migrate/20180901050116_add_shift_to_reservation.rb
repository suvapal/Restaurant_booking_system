class AddShiftToReservation < ActiveRecord::Migration[5.0]
  def change
    add_column :reservations, :shift, :string
  end
end

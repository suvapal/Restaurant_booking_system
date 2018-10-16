class AddMaxToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :max, :integer
  end
end

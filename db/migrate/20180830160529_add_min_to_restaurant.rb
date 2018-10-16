class AddMinToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :min, :integer
  end
end

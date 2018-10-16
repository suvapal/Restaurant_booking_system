class AddTableToRestaurant < ActiveRecord::Migration[5.0]
  def change
    add_column :restaurants, :table, :integer
  end
end

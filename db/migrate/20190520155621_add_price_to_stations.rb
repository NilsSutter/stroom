class AddPriceToStations < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :price, :integer
  end
end

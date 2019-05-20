class AddPriceToStations < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :price, :float
  end
end

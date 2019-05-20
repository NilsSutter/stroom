class AddPhotoToStations < ActiveRecord::Migration[5.2]
  def change
    add_column :stations, :photo, :string
  end
end

class CreateStations < ActiveRecord::Migration[5.2]
  def change
    create_table :stations do |t|
      t.string :address
      t.string :type
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end

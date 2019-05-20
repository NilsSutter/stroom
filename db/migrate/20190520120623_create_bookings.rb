class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.references :user, foreign_key: true
      t.references :station, foreign_key: true
      t.boolean :confirmed, default: false
      t.datetime :start
      t.datetime :end

      t.timestamps
    end
  end
end

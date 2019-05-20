class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :station, through: :bookings
end

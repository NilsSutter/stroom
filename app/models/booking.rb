class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :station
  has_many :reviews
end

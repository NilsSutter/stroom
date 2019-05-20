class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :station
  has_many :reviews
  validates :user_id, :station_id, :start, :end, presence: true
  validates :start, :end, overlap: true
end

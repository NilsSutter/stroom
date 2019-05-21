class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :station
  has_many :reviews
  validates :user, :station, :start, :end, presence: true
  validates :start, :end, overlap: true
end

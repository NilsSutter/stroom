class Booking < ApplicationRecord
  belongs_to :user
  belongs_to :station
  has_many :reviews, dependent: :destroy
  validates :user, :station, :start, :end, presence: true
  validates :start, :end, overlap: true
end

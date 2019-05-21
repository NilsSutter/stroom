class Station < ApplicationRecord
  CHARGER_TYPES = ["tesla", "mercedes", "bmw", "volkswagen", "volvo", "ford"]

  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings
  validates :address, :charger, :user, presence: true
  validates_inclusion_of :charger, in: CHARGER_TYPES
end

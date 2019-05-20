class Station < ApplicationRecord
  belongs_to :user
  has_many :bookings
  has_many :reviews, through: :bookings
  validates :address, :charger, :user_id, presence: true
  validates :charger, inclusion: { in: ["Tesla", "Mercedes", "BMW", "Volkswagen", "Volvo", "Ford"] }
end

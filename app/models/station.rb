class Station < ApplicationRecord
  CHARGER_TYPES = ["tesla", "mercedes", "bmw", "volkswagen", "volvo", "ford"]

  belongs_to :user
  has_many :bookings, dependent: :destroy
  has_many :reviews, dependent: :destroy
  validates :address, :charger, :user, presence: true
  validates_inclusion_of :charger, in: CHARGER_TYPES

  mount_uploader :photo, PhotoUploader
  geocoded_by :address
  after_validation :geocode, if: :will_save_change_to_address?

  include PgSearch
  pg_search_scope :search_by_station_and_charger,
                  against: [:stations, :charger],
                  using: {
                  tsearch: { prefix: true } # <-- now `superman batm` will return something!
                  }

   # Methods for review computations
  def compute_overall_avg
    self.reviews.count == 0 ? 0 : ((compute_accessability + compute_condition) / 2).round
  end

  def compute_accessability
    accessability = []
    self.reviews.each do |review|
      accessability << review.accessability
    end
    accessability.size.zero? ? 0 : accessability.inject(0) { |sum, num| sum + num } / accessability.size
  end

  def compute_condition
    condition = []
    self.reviews.each do |review|
      condition << review.condition
    end
    condition.size.zero? ? 0 : condition.inject(0) { |sum, num| sum + num } / condition.size
  end
end

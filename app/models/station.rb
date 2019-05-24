class Station < ApplicationRecord
  CHARGER_TYPES = ["tesla", "mercedes", "bmw", "volkswagen", "volvo", "ford"]

  belongs_to :user
  has_many :bookings
  has_many :reviews
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
    (compute_accessibility + compute_condition) / 2
  end

  def compute_accessibility
    accessibility = []
    self.reviews.each do |review|
      accessibility << review.accessability
    end
    accessibility_sum = accessibility.reduce(0) { |sum, num| sum + num }
    accessibility_sum.to_f / accessibility.count
  end

  def compute_condition
    condition = []
    self.reviews.each do |review|
      condition << review.condition
    end
    condition_sum = condition.reduce(0) { |sum, num| sum + num }
    condition_sum.to_f / condition.count
  end
end

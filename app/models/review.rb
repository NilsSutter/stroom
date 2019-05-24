class Review < ApplicationRecord
  belongs_to :booking
  belongs_to :station
  validates :accessability, :condition, presence: true, inclusion: { in: [0, 1, 2, 3, 4, 5] }
  validates :booking, :station, presence: true
  #validates :content, presence: true
end

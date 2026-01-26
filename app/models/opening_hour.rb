class OpeningHour < ApplicationRecord
  belongs_to :venue

  validates :day_of_week, presence: true, inclusion: { in: 0..6 }
  validates :open_time, presence: true
  validates :close_time, presence: true
end

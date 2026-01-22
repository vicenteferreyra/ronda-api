class Venue < ApplicationRecord
  has_many :venue_tags
  has_many :tags, through: :venue_tags
  has_one_attached :image

  validates :name, presence: true
end

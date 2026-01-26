class Tag < ApplicationRecord
  has_many :venue_tags
  has_many :venues, through: :venue_tags

  enum :tag_type, { cuisine: 0, service: 1, atmosphere: 2, meal_type: 3 }

  before_validation :normalize_name
  validates :name, presence: true, uniqueness: true
  validates :tag_type, presence: true

  private

  def normalize_name
    self.name = name.to_s.downcase.strip
  end
end

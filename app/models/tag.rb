class Tag < ApplicationRecord
  has_many :venue_tags
  has_many :venues, through: :venue_tags

  before_validation :normalize_name
  validates :name, presence: true, uniqueness: true

  private

  def normalize_name
    self.name = name.to_s.downcase.strip
  end
end

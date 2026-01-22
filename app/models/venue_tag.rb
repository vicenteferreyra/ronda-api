class VenueTag < ApplicationRecord
  belongs_to :venue
  belongs_to :tag

  validates :venue_id, uniqueness: { scope: :tag_id }
end

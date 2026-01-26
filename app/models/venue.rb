class Venue < ApplicationRecord
  has_many :venue_tags
  has_many :tags, through: :venue_tags
  has_many :opening_hours
  has_one_attached :image
  has_many_attached :gallery_images

  validates :name, presence: true

  def is_open_now?
    now = Time.current
    current_day = now.wday
    current_time = now.strftime("%H:%M:%S")

    opening_hours.where(day_of_week: current_day).any? do |hour|
      hour.open_time.strftime("%H:%M:%S") <= current_time &&
        hour.close_time.strftime("%H:%M:%S") >= current_time
    end
  end

  def tags_by_type
    result = { "cuisine" => [], "service" => [], "atmosphere" => [], "meal_type" => [] }
    tags.group_by(&:tag_type).each do |tag_type, tag_list|
      result[tag_type.to_s] = tag_list.map { |tag| { id: tag.id, name: tag.name, display_name: tag.display_name || tag.name.humanize } }
    end
    result
  end
end

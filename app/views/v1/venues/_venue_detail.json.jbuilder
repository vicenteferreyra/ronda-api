json.partial! "v1/venues/venue", venue: venue

json.gallery_images venue.gallery_images.attached? ? venue.gallery_images.map { |img| rails_blob_url(img) } : []
json.phone_number venue.phone_number
json.website venue.website
json.description venue.description
json.opening_hours venue.opening_hours do |hour|
  json.day_of_week hour.day_of_week
  json.open_time hour.open_time.strftime("%H:%M")
  json.close_time hour.close_time.strftime("%H:%M")
end
json.is_open_now venue.is_open_now?

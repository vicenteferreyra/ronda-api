json.id venue.id
json.name venue.name
json.price_range venue.price_range
json.tags venue.tags_by_type
json.address venue.address
json.latitude venue.latitude&.to_f
json.longitude venue.longitude&.to_f
json.image_url venue.image.attached? ? rails_blob_url(venue.image) : nil
json.distance "#{rand(1..9)} km"
json.rating 0
json.review_count 0
json.favorited false
json.created_at venue.created_at
json.updated_at venue.updated_at

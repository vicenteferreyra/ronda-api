# frozen_string_literal: true

require "open-uri"

VenueTag.destroy_all
Venue.destroy_all
Tag.destroy_all

%w[restaurant bar cafe rooftop live\ music brunch pizza sushi outdoor].each { |n| Tag.find_or_create_by!(name: n) }

def attach_image(venue, image_url)
  venue.image.attach(io: URI.parse(image_url).open, filename: "venue-#{venue.id}.jpg", content_type: "image/jpeg")
rescue StandardError => e
  Rails.logger.warn "Could not attach image for #{venue.name}: #{e.message}"
end

venues_data = [
  { name: "Trattoria Romano", price_range: "$$", address: "88 Mulberry St, Manhattan", lat: 40.716, lng: -73.998, tag_names: %w[restaurant], image: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=600&fit=crop" },
  { name: "Sakura Sushi Bar", price_range: "$$$", address: "156 W 44th St, Manhattan", lat: 40.757, lng: -73.986, tag_names: %w[sushi restaurant], image: "https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800&h=600&fit=crop" },
  { name: "El Mariachi", price_range: "$$", address: "321 E 9th St, Manhattan", lat: 40.728, lng: -73.982, tag_names: %w[restaurant bar], image: "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&h=600&fit=crop" },
  { name: "Bella Vista Ristorante", price_range: "$$$", address: "412 Amsterdam Ave, Manhattan", lat: 40.784, lng: -73.977, tag_names: %w[restaurant], image: "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800&h=600&fit=crop" },
  { name: "Green Leaf Cafe", price_range: "$", address: "234 Bedford Ave, Brooklyn", lat: 40.714, lng: -73.961, tag_names: %w[cafe brunch], image: "https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&h=600&fit=crop" },
  { name: "Steakhouse Prime", price_range: "$$$", address: "123 E 54th St, Manhattan", lat: 40.759, lng: -73.970, tag_names: %w[restaurant], image: "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&h=600&fit=crop" },
  { name: "Thai Garden", price_range: "$$", address: "79 2nd Ave, Manhattan", lat: 40.731, lng: -73.989, tag_names: %w[restaurant], image: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=600&fit=crop" },
  { name: "Le Bistro Français", price_range: "$$$", address: "411 W 42nd St, Manhattan", lat: 40.759, lng: -73.992, tag_names: %w[restaurant cafe], image: "https://images.unsplash.com/photo-1551218808-94e220e084d2?w=800&h=600&fit=crop" }
]

venues_data.each do |data|
  venue = Venue.create!(name: data[:name], price_range: data[:price_range], address: data[:address], latitude: data[:lat], longitude: data[:lng])
  data[:tag_names].each { |tn| venue.tags << Tag.find_by!(name: tn) }
  attach_image(venue, data[:image])
end

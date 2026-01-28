# frozen_string_literal: true

require "open-uri"

User.destroy_all
VenueTag.destroy_all
OpeningHour.destroy_all
Venue.destroy_all
Tag.destroy_all

# Cuisine tags
%w[italian japanese mexican thai french american].each do |n|
  Tag.find_or_create_by!(name: n) do |tag|
    tag.tag_type = :cuisine
    tag.display_name = n.capitalize
  end
end

# Service tags
%w[wifi accepts\ cards parking outdoor\ seating reservations delivery takeout].each do |n|
  Tag.find_or_create_by!(name: n) do |tag|
    tag.tag_type = :service
    tag.display_name = n.humanize
  end
end

# Atmosphere tags
%w[rooftop live\ music outdoor].each do |n|
  Tag.find_or_create_by!(name: n) do |tag|
    tag.tag_type = :atmosphere
    tag.display_name = n.humanize
  end
end

# Meal type tags
%w[brunch lunch dinner].each do |n|
  Tag.find_or_create_by!(name: n) do |tag|
    tag.tag_type = :meal_type
    tag.display_name = n.capitalize
  end
end

def attach_image(venue, image_url)
  venue.image.attach(io: URI.parse(image_url).open, filename: "venue-#{venue.id}.jpg", content_type: "image/jpeg")
rescue StandardError => e
  Rails.logger.warn "Could not attach image for #{venue.name}: #{e.message}"
end

def attach_gallery_images(venue, image_urls)
  image_urls.each do |url|
    venue.gallery_images.attach(io: URI.parse(url).open, filename: "venue-#{venue.id}-gallery-#{rand(1000)}.jpg", content_type: "image/jpeg")
  end
rescue StandardError => e
  Rails.logger.warn "Could not attach gallery image for #{venue.name}: #{e.message}"
end

def create_opening_hours(venue, hours)
  hours.each do |day, times|
    venue.opening_hours.create!(day_of_week: day, open_time: times[:open], close_time: times[:close])
  end
end

venues_data = [
  {
    name: "Trattoria Romano",
    price_range: "$$",
    address: "88 Mulberry St, Manhattan",
    lat: 40.716,
    lng: -73.998,
    phone_number: "+1 (212) 555-0101",
    website: "https://trattoriaromano.com",
    description: "Authentic Italian cuisine in the heart of Little Italy. Family-owned since 1985, serving traditional pasta dishes and wood-fired pizzas.",
    tag_names: %w[italian wifi accepts\ cards reservations],
    image: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=600&fit=crop",
    gallery_images: [
      "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&h=600&fit=crop",
      "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800&h=600&fit=crop"
    ],
    opening_hours: {
      0 => { open: "12:00", close: "22:00" },
      1 => { open: "11:30", close: "22:30" },
      2 => { open: "11:30", close: "22:30" },
      3 => { open: "11:30", close: "22:30" },
      4 => { open: "11:30", close: "23:00" },
      5 => { open: "11:30", close: "23:00" },
      6 => { open: "12:00", close: "22:00" }
    }
  },
  {
    name: "Sakura Sushi Bar",
    price_range: "$$$",
    address: "156 W 44th St, Manhattan",
    lat: 40.757,
    lng: -73.986,
    phone_number: "+1 (212) 555-0102",
    website: "https://sakurasushi.com",
    description: "Premium sushi and Japanese cuisine. Fresh fish flown in daily from Tokyo's Tsukiji market. Omakase available.",
    tag_names: %w[japanese wifi accepts\ cards reservations],
    image: "https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800&h=600&fit=crop",
    gallery_images: [
      "https://images.unsplash.com/photo-1579584425555-c3ce17fd4351?w=800&h=600&fit=crop",
      "https://images.unsplash.com/photo-1551218808-94e220e084d2?w=800&h=600&fit=crop"
    ],
    opening_hours: {
      0 => { open: "17:00", close: "23:00" },
      1 => { open: "17:00", close: "23:00" },
      2 => { open: "17:00", close: "23:00" },
      3 => { open: "17:00", close: "23:00" },
      4 => { open: "17:00", close: "00:00" },
      5 => { open: "17:00", close: "00:00" },
      6 => { open: "17:00", close: "23:00" }
    }
  },
  {
    name: "El Mariachi",
    price_range: "$$",
    address: "321 E 9th St, Manhattan",
    lat: 40.728,
    lng: -73.982,
    phone_number: "+1 (212) 555-0103",
    website: "https://elmariachi.com",
    description: "Vibrant Mexican restaurant and bar with live mariachi music on weekends. Famous for margaritas and authentic tacos.",
    tag_names: %w[mexican wifi accepts\ cards outdoor\ seating live\ music],
    image: "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&h=600&fit=crop",
    gallery_images: [
      "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=600&fit=crop"
    ],
    opening_hours: {
      0 => { open: "12:00", close: "23:00" },
      1 => { open: "11:00", close: "23:00" },
      2 => { open: "11:00", close: "23:00" },
      3 => { open: "11:00", close: "23:00" },
      4 => { open: "11:00", close: "00:00" },
      5 => { open: "11:00", close: "01:00" },
      6 => { open: "12:00", close: "23:00" }
    }
  },
  {
    name: "Bella Vista Ristorante",
    price_range: "$$$",
    address: "412 Amsterdam Ave, Manhattan",
    lat: 40.784,
    lng: -73.977,
    phone_number: "+1 (212) 555-0104",
    website: "https://bellavista.com",
    description: "Upscale Italian dining with panoramic city views. Specializing in Northern Italian cuisine and an extensive wine selection.",
    tag_names: %w[italian wifi accepts\ cards reservations parking],
    image: "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800&h=600&fit=crop",
    gallery_images: [
      "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&h=600&fit=crop"
    ],
    opening_hours: {
      0 => { open: "17:00", close: "22:00" },
      1 => { open: "17:00", close: "22:30" },
      2 => { open: "17:00", close: "22:30" },
      3 => { open: "17:00", close: "22:30" },
      4 => { open: "17:00", close: "23:00" },
      5 => { open: "17:00", close: "23:00" },
      6 => { open: "17:00", close: "22:00" }
    }
  },
  {
    name: "Green Leaf Cafe",
    price_range: "$",
    address: "234 Bedford Ave, Brooklyn",
    lat: 40.714,
    lng: -73.961,
    phone_number: "+1 (718) 555-0105",
    website: "https://greenleafcafe.com",
    description: "Cozy neighborhood cafe serving organic coffee, fresh pastries, and healthy brunch options. Pet-friendly outdoor seating.",
    tag_names: %w[brunch wifi accepts\ cards outdoor\ seating takeout],
    image: "https://images.unsplash.com/photo-1512058564366-18510be2db19?w=800&h=600&fit=crop",
    gallery_images: [
      "https://images.unsplash.com/photo-1551218808-94e220e084d2?w=800&h=600&fit=crop"
    ],
    opening_hours: {
      0 => { open: "08:00", close: "18:00" },
      1 => { open: "07:00", close: "19:00" },
      2 => { open: "07:00", close: "19:00" },
      3 => { open: "07:00", close: "19:00" },
      4 => { open: "07:00", close: "19:00" },
      5 => { open: "07:00", close: "19:00" },
      6 => { open: "08:00", close: "18:00" }
    }
  },
  {
    name: "Steakhouse Prime",
    price_range: "$$$",
    address: "123 E 54th St, Manhattan",
    lat: 40.759,
    lng: -73.970,
    phone_number: "+1 (212) 555-0106",
    website: "https://steakhouseprime.com",
    description: "Premium steakhouse featuring dry-aged beef and an extensive selection of fine wines. Elegant atmosphere perfect for special occasions.",
    tag_names: %w[italian wifi accepts\ cards reservations parking],
    image: "https://images.unsplash.com/photo-1555939594-58d7cb561ad1?w=800&h=600&fit=crop",
    gallery_images: [
      "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=600&fit=crop"
    ],
    opening_hours: {
      0 => { open: "17:00", close: "22:00" },
      1 => { open: "17:00", close: "22:30" },
      2 => { open: "17:00", close: "22:30" },
      3 => { open: "17:00", close: "22:30" },
      4 => { open: "17:00", close: "23:00" },
      5 => { open: "17:00", close: "23:00" },
      6 => { open: "17:00", close: "22:00" }
    }
  },
  {
    name: "Thai Garden",
    price_range: "$$",
    address: "79 2nd Ave, Manhattan",
    lat: 40.731,
    lng: -73.989,
    phone_number: "+1 (212) 555-0107",
    website: "https://thaigarden.com",
    description: "Authentic Thai cuisine with bold flavors and fresh ingredients. Vegetarian and vegan options available.",
    tag_names: %w[thai wifi accepts\ cards delivery takeout],
    image: "https://images.unsplash.com/photo-1517248135467-4c7edcad34c4?w=800&h=600&fit=crop",
    gallery_images: [
      "https://images.unsplash.com/photo-1555396273-367ea4eb4db5?w=800&h=600&fit=crop"
    ],
    opening_hours: {
      0 => { open: "12:00", close: "22:00" },
      1 => { open: "11:30", close: "22:30" },
      2 => { open: "11:30", close: "22:30" },
      3 => { open: "11:30", close: "22:30" },
      4 => { open: "11:30", close: "23:00" },
      5 => { open: "11:30", close: "23:00" },
      6 => { open: "12:00", close: "22:00" }
    }
  },
  {
    name: "Le Bistro Français",
    price_range: "$$$",
    address: "411 W 42nd St, Manhattan",
    lat: 40.759,
    lng: -73.992,
    phone_number: "+1 (212) 555-0108",
    website: "https://lebistrofrancais.com",
    description: "Classic French bistro serving traditional dishes like coq au vin and bouillabaisse. Intimate atmosphere with French wine selection.",
    tag_names: %w[french wifi accepts\ cards reservations],
    image: "https://images.unsplash.com/photo-1551218808-94e220e084d2?w=800&h=600&fit=crop",
    gallery_images: [
      "https://images.unsplash.com/photo-1559339352-11d035aa65de?w=800&h=600&fit=crop"
    ],
    opening_hours: {
      0 => { open: "17:00", close: "22:00" },
      1 => { open: "12:00", close: "22:30" },
      2 => { open: "12:00", close: "22:30" },
      3 => { open: "12:00", close: "22:30" },
      4 => { open: "12:00", close: "23:00" },
      5 => { open: "12:00", close: "23:00" },
      6 => { open: "17:00", close: "22:00" }
    }
  }
]

venues_data.each do |data|
  venue = Venue.create!(
    name: data[:name],
    price_range: data[:price_range],
    address: data[:address],
    latitude: data[:lat],
    longitude: data[:lng],
    phone_number: data[:phone_number],
    website: data[:website],
    description: data[:description]
  )

  data[:tag_names].each { |tn| venue.tags << Tag.find_by!(name: tn) }
  attach_image(venue, data[:image])
  attach_gallery_images(venue, data[:gallery_images]) if data[:gallery_images]
  create_opening_hours(venue, data[:opening_hours])
end

# Create test user
User.find_or_create_by!(email: "test@example.com") do |user|
  user.name = "Test User"
  user.password = "password123"
  user.provider = "email"
end

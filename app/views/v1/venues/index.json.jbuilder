json.array! @venues do |venue|
  json.partial! "v1/venues/venue", venue: venue
end

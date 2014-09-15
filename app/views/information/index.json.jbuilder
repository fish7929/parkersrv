json.array!(@information) do |information|
  json.extract! information, :id, :uuid, :garage_name, :total_parking_space, :position, :longitude, :latitude
  json.url information_url(information, format: :json)
end

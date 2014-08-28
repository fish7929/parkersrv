json.array!(@parkers) do |parker|
  json.extract! parker, :id, :garage_name, :point, :total_parking_spaces, :remaining_parking_spaces, :address, :price, :isOpen, :status, :road_garage
  json.url parker_url(parker, format: :json)
end

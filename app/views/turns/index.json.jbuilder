json.array!(@turns) do |turn|
  json.extract! turn, :id, :uuid, :garage_num, :total_parking_number
  json.url turn_url(turn, format: :json)
end

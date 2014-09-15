json.array!(@statuses) do |status|
  json.extract! status, :id, :uuid, :garage_num, :parking_num, :rom_num, :status
  json.url status_url(status, format: :json)
end

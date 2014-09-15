json.array!(@events) do |event|
  json.extract! event, :id, :uuid, :rom_num, :event, :last_time
  json.url event_url(event, format: :json)
end

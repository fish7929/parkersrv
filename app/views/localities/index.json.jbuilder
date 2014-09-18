json.array!(@localities) do |locality|
  json.extract! locality, :id,:uuid, :code, :parentId, :name, :garageNum, :level
  json.url locality_url(locality, format: :json)
end

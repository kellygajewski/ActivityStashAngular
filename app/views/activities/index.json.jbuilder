json.array!(@activities) do |activity|
  json.extract! activity, :id, :latitude, :longitude, :location, :name, :link, :notes, :category_ids => []
  json.url activity_url(activity, format: :json)
end
json.array!(@albums) do |album|
  json.extract! album, :id, :name, :genre
  json.url album_url(album, format: :json)
end

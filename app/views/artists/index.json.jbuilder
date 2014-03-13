json.array!(@artists) do |artist|
  json.extract! artist, :id, :name, :gender
  json.url artist_url(artist, format: :json)
end

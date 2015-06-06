json.array!(@urls) do |url|
  json.extract! url, :id, :origin, :shorted, :user
  json.url url_url(url, format: :json)
end

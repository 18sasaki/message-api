json.array!(@matchings) do |matching|
  json.extract! matching, :id, :customer_id, :store_id
  json.url matching_url(matching, format: :json)
end

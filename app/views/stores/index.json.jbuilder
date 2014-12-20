json.array!(@stores) do |store|
  json.extract! store, :id, :user_id, :name, :address, :geo_data, :mail_address, :memo
  json.url store_url(store, format: :json)
end

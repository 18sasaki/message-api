json.array!(@users) do |user|
  json.extract! user, :id, :user_id, :password, :user_type
  json.url user_url(user, format: :json)
end

json.array!(@users) do |user|
  json.extract! user, :id, :password, :user_type
  json.url user_url(user, format: :json)
end

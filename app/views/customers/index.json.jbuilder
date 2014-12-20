json.array!(@customers) do |customer|
  json.extract! customer, :id, :user_id, :name, :mail_address, :memo
  json.url customer_url(customer, format: :json)
end

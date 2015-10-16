json.array!(@users) do |user|
  json.extract! user, :id, :name, :email, :password, :set_flag
  json.url user_url(user, format: :json)
end

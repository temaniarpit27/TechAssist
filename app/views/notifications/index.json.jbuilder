json.array!(@notifications) do |notification|
  json.extract! notification, :id, :description, :user_id, :question_id
  json.url notification_url(notification, format: :json)
end

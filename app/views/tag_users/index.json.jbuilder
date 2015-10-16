json.array!(@tag_users) do |tag_user|
  json.extract! tag_user, :id, :user_id, :question_id
  json.url tag_user_url(tag_user, format: :json)
end

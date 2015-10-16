json.array!(@comments) do |comment|
  json.extract! comment, :id, :entity_id, :entity_type, :comment, :user_id
  json.url comment_url(comment, format: :json)
end

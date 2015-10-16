json.array!(@votes) do |vote|
  json.extract! vote, :id, :entity_id, :entity_type, :user_id, :vote_flag
  json.url vote_url(vote, format: :json)
end

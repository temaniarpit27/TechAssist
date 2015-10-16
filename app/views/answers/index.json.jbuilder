json.array!(@answers) do |answer|
  json.extract! answer, :id, :answer, :question_id, :user_id
  json.url answer_url(answer, format: :json)
end

json.array!(@asked_to_answers) do |asked_to_answer|
  json.extract! asked_to_answer, :id, :question_id, :user_id
  json.url asked_to_answer_url(asked_to_answer, format: :json)
end

class Answer < ActiveRecord::Base
  belongs_to :question, class_name: "::Question", foreign_key: :question_id
  belongs_to :user, class_name: "::User", foreign_key: :user_id

  has_many :comments, as: :entity, class_name: "::Comment"
	has_many :votes, as: :entity, class_name: "::Vote"
end

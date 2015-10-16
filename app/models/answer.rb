class Answer < ActiveRecord::Base
  belongs_to :question, class_name: "::Question"
  belongs_to :user, class_name: "::User"

  has_many :comments, as: :entity, class_name: "::Comment"
	has_many :votes, as: :entity, class_name: "::Vote"
end

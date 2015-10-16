class Question < ActiveRecord::Base
	belongs_to :user, class_name: "::User"
	belongs_to :repo_tag, class_name: "::Repository"
	has_many :answers, class_name: "::Answer"

	has_many :comments, as: :entity, class_name: "::Comment"
	has_many :votes, as: :entity, class_name: "::Vote"
end

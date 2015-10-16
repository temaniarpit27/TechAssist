class User < ActiveRecord::Base
	has_many :user_repo_joins, class_name: "::UserRepoJoin"
	has_many :repositories, class_name: "::Repository", through: :user_repo_joins
	has_many :questions, class_name: "::Question"
	has_many :answers, class_name: "::Answer"
	has_many :comments, class_name: "::Comment"
	has_many :votes, class_name: "::Vote"
	validates_presence_of :name , :email , :password
end

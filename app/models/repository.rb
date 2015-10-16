class Repository < ActiveRecord::Base
	has_many :user_repo_joins , class_name: "UserRepoJoin"
	has_many :users , through: :user_repo_joins
end

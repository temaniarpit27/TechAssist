class User < ActiveRecord::Base
	validates_presence_of :name , :email , :password
	has_many :user_repo_joins , class_name: "UserRepoJoin"
	has_many :repositories , through: :user_repo_joins
end

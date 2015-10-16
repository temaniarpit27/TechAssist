class UserRepoJoin < ActiveRecord::Base
	validates_presence_of :user_id , :repo_id
	belongs_to :user, class_name: "User"
	belongs_to :repositories , class_name: "Repository"
end

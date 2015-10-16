class UserRepoJoin < ActiveRecord::Base
	belongs_to :user , class_name:"User"
	belongs_to :repository , class_name: "Repository"

	validates_presence_of :user_id , :repo_id
end

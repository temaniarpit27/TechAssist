class UserRepoJoin < ActiveRecord::Base
	belongs_to :user , class_name: "User", foreign_key: :user_id
	belongs_to :repository , class_name: "Repository", foreign_key: :repository_id

	validates_presence_of :user , :repository
end

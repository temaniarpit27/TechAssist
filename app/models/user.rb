class User < ActiveRecord::Base
	has_many :user_repo_joins, class_name: "::UserRepoJoin"
	has_many :repositories, class_name: "::Repository", through: :user_repo_joins
	has_many :questions, class_name: "::Question"
	has_many :answers, class_name: "::Answer"
	has_many :comments, class_name: "::Comment"
	has_many :votes, class_name: "::Vote"
	validates_presence_of :name , :email , :password
<<<<<<< HEAD

  def self.add_repository(params)
    tags = params[:tags]
    tags.each do |tag|
      a = UserRepoJoin.new(:user_id => params[:user_id], :repository_id => tag)
      a.save
    end
  end
=======
	has_many :user_repo_joins , class_name: "UserRepoJoin"
	has_many :repositories , through: :user_repo_joins
>>>>>>> ebdc4bf33f8ae603eebbead93858e652f880edb0
end

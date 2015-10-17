class Question < ActiveRecord::Base
  belongs_to :user, class_name: "::User", foreign_key: :user_id
  belongs_to :repo_tag, class_name: "::Repository", foreign_key: :repository_id
  has_many :answers, class_name: "::Answer"

  has_many :comments, as: :entity, class_name: "::Comment"
  has_many :votes, as: :entity, class_name: "::Vote"
  has_many :tag_users, class_name: "::TagUser"
  has_one :asked_to_answer, class_name: "::AskedToAnswer"

  searchable do
    text :title
    text :description
    integer :repository_id
    integer :user_id
    string :sort_title do
      title.downcase.gsub(/^(an?|the)/, '')
    end
  end

  def self.search_full(query)
    Question.search{fulltext query}.results[0...5]
  end

  def self.search_with_repo(params)
    byebug
    query = params[:q]
    repo_id = params[:repo_id].to_i
    res = Question.search do
            fulltext query
            with :repository_id, repo_id
          end
    res.results[0...5]
  end
end

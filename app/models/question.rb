class Question < ActiveRecord::Base
  belongs_to :user, class_name: "::User", foreign_key: :user_id
  belongs_to :repo_tag, class_name: "::Repository", foreign_key: :repository_id
  has_many :answers, class_name: "::Answer"

  has_many :comments, as: :entity, class_name: "::Comment"
  has_many :votes, as: :entity, class_name: "::Vote"

  searchable do
    text :title
    integer :repository_id
    integer :user_id
    string :sort_title do
      title.downcase.gsub(/^(an?|the)/, '')
    end
  end

  def self.search_title(params)
    query = params[:string]
    Question.search{fulltext query}.results
  end
end

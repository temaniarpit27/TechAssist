class User < ActiveRecord::Base
	has_many :user_repo_joins, class_name: "::UserRepoJoin" , dependent: :destroy
	has_many :repositories, class_name: "::Repository", through: :user_repo_joins , dependent: :destroy
	has_many :questions, class_name: "::Question" , dependent: :destroy
	has_many :answers, class_name: "::Answer" , dependent: :destroy
	has_many :comments, class_name: "::Comment" , dependent: :destroy
	has_many :votes, class_name: "::Vote" , dependent: :destroy
  has_many :repo_contributors, class_name: "::RepoContributor" , dependent: :destroy
	validates_presence_of :name  

  has_many :notifications, class_name: "::Notification"


  def get_all_users
    for id in 1..3
      url = URI("https://api.github.com/orgs/loconsolutions/members?page=#{id}&per_page=100")
      req = Net::HTTP::Get.new(url)
      req['Content-Type'] = "application/json"
      req['Authorization'] = 'token 9455d555cb1e8061a42bb2610af79e3b9201a72a'
      req['Accept'] = 'application/json'

      res = Net::HTTP.start(url.hostname, url.port,:use_ssl => true) {|http|
        http.request(req)
      }

      body = JSON.parse(res.body)
      body.each do |user|
        User.create(:name => user["login"], :email => "abc", :password => "pass")
      end
    end
  end

  def self.add_repository(params)
    tags = params[:tags]
    tags.each do |tag|
      a = UserRepoJoin.new(:user_id => params[:user_id], :repository_id => tag)
      a.save
    end
  end

  def self.populate_users_table
    uri = URI('https://api.github.com/orgs/loconsolutions/public_members')
    users = Oj.load(Net::HTTP.get(uri))
  end

  def repo_related_home_details(repository_id , status)
    unanswered_questions = []
    repo_questions = Question.where(:repository_id => repository_id).order(created_at: :desc) if status == "recent"
    repo_questions = Question.where(:repository_id => repository_id).joins(:votes).select("questions.id,questions.title,questions.description, count(votes.id) as vote_count").group("questions.id").order("vote_count DESC") if status == "trending"
    questions_in_repo = Question.where(:repository_id => repository_id).pluck(:id)
    questions_in_repo_having_answer =  Question.where(:repository_id => repository_id).joins(:answers).select("questions.id").group("questions.id").pluck(:id)
    questions_in_repo.each do |question|
      if !(questions_in_repo_having_answer.include? question)
        unanswered_questions.push(question)
      end
    end
    repo_questions = Questions.where(:id => unanswered_questions) if status == "unanswered"
    return repo_questions
  end

  def get_all_home_details(params)
    unanswered_questions = []
    user_repo_watch = UserRepoJoin.where(:user_id => params[:id].to_i).pluck(:repository_id)
    repo_questions = Question.where(:repository_id => user_repo_watch).order(created_at: :desc) if params[:status] == "recent"
    repo_questions = Question.where(:repository_id => user_repo_watch).joins(:votes).select("questions.id,questions.title,questions.description, count(votes.id) as vote_count").group("questions.id").order("vote_count DESC") if params[:status] == "trending"
    questions_in_repo = Question.where(:repository_id => user_repo_watch).pluck(:id)
    questions_in_repo_having_answer =  Question.where(:repository_id => user_repo_watch).joins(:answers).select("questions.id").group("questions.id").pluck(:id)
    questions_in_repo.each do |question|
      if !(questions_in_repo_having_answer.include? question)
        unanswered_questions.push(question)
      end
    end
    repo_questions = Question.where(:id => unanswered_questions) if params[:status] == "unanswered"
    return repo_questions
  end
end

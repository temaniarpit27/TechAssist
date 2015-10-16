class User < ActiveRecord::Base
	has_many :user_repo_joins, class_name: "::UserRepoJoin"
	has_many :repositories, class_name: "::Repository", through: :user_repo_joins
	has_many :questions, class_name: "::Question"
	has_many :answers, class_name: "::Answer"
	has_many :comments, class_name: "::Comment"
	has_many :votes, class_name: "::Vote"
  has_many :repo_contributors, class_name: "::ReposContributor"
	validates_presence_of :name  

  def get_all_users 
    for id in 1..3
      url = URI("https://api.github.com/orgs/loconsolutions/members?page=#{id}&per_page=100")
      req = Net::HTTP::Get.new(url)
      req['Content-Type'] = "application/json"
      req['Authorization'] = 'token'
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
    byebug
  end
end

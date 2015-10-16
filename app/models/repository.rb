class Repository < ActiveRecord::Base
	has_many :user_repo_joins , class_name: "UserRepoJoin"
	has_many :users , through: :user_repo_joins
	has_many :questions, class_name: "::Question"
	has_many :repo_contributors, class_name: "RepoContributor"

	def get_all_repos
    for id in 1..3
      url = URI("https://api.github.com/orgs/loconsolutions/repos?per_page=100&page=#{id}")
      req = Net::HTTP::Get.new(url)
      req['Content-Type'] = "application/json"
      req['Authorization'] = 'token '
      req['Accept'] = 'application/json'
    
      res = Net::HTTP.start(url.hostname, url.port,:use_ssl => true) {|http|
        http.request(req)
      }

      body = JSON.parse(res.body)
      body.each do |repo|
        Repository.create(:name => repo["name"])
      end
    end
  end 

end

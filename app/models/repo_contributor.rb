class RepoContributor < ActiveRecord::Base
	belongs_to :user , class_name: "User", foreign_key: :user_id
	belongs_to :repository , class_name: "Repository", foreign_key: :repository_id

	validates_presence_of :user , :repository
	def get_all_contributors
	repos = Repository.all
    for repo in repos
      url = URI("https://api.github.com/repos/loconsolutions/#{repo.name}/contributors")
      req = Net::HTTP::Get.new(url)
      req['Content-Type'] = "application/json"
      req['Authorization'] = 'token 03a8bf85550eb3ac15ce0cab401c65af6e017106'
      req['Accept'] = 'application/json'
    
      res = Net::HTTP.start(url.hostname, url.port,:use_ssl => true) {|http|
        http.request(req)
      }
      puts res.body
      body = JSON.parse(res.body)
      body.each do |contributor|
      	#puts contributor
      	user = User.find_by(:name => contributor["login"]) 
      	if !user.nil?
        	RepoContributor.create({:user_id => user.id , :repository_id => repo.id, :contributions => contributor["contributions"]})
    	end
      end
    end
  end 
end

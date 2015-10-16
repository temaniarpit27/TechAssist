module UsersHelper
	require 'net/http'

	def get_all_users 
		for id in 1..3
			url = "https://api.github.com/orgs/loconsolutions/members?page=#{id}&per_page=100"
			req = Net::HTTP::Get.new(url)
			req['Content-Type'] = "application/json"
			req['Authorization'] = 'token 48a5f6ad3d97d3607ab0468cf32bc672fdc46dd2'
			req['Accept'] = 'application/json'
			res = Net::HTTP.start(uri.hostname, uri.port) {|http|
  			http.request(req)
			}
			puts res
		end
	end	

end

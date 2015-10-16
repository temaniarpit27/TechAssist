module VotesHelper
	def get_votes question
		votes = question.votes
		upvotes = 0
		downvotes = 0
		for vote in votes do
			if(vote.vote_flag) 
				upvotes = upvotes+1
			else
				downvotes = downvotes +1
			end
			
		end

		{upvotes: upvotes, downvotes: downvotes}
	end
end

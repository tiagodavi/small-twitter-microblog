class NotificationsController < FullController
	
	include ActionController::Live

	before_action :require_authentication
	
	def connect			
		response.headers['Content-Type'] = 'text/event-stream'

		new_followers = current_user.new_followers
		users = []

		if new_followers.present?			
			users = new_followers.collect { |f| "@#{f.follower.login}" } 					
		end	 

		response.stream.write "retry: 60000\n"
		response.stream.write "event: message\n"
		response.stream.write "data: #{JSON.dump(users)}\n\n" 

		ensure
			response.stream.close 
	end
end
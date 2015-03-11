class SignupsController < BasicController
	def index
		new_user		
	end
	def create
		new_user
		if @user.save     
			render text: 'ok'
		else
			render action: :index
		end
	end
	private
	 def user_params
		params.require(:user).permit(
			:name,
			:email, 
			:login, 
			:password		
		)			
	 end
	 def new_user   		
		@user = params[:user] ? User.new(user_params) : User.new
		@tweets = Tweet.last(3)
	 end			
end
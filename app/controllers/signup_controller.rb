class SignupController < BasicController

	def index
		new_user		
	end

	def create
		new_user
		if @user.save     
			user_session.register(@user)			
			redirect_to profile_path
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
		@user_session = user_session
		@tweets = Tweet.most_recent.limit(3)
	 end			
end
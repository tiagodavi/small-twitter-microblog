class LoginController < BasicController

	def enter				
		@user_session = UserSession.new(session, user_session_params)
		if @user_session.authenticate!			
			redirect_to profile_path
		else
			redirect_to root_path, notice: t('flash.notice.invalid_login')
		end
	end

	def exit
		user_session.destroy
		redirect_to root_path
	end

	private

	def user_session_params
		params.require(:user_session).permit(:login, :password)						
	 end
end
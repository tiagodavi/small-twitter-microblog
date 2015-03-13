class ProfileController < FullController

	before_action :require_authentication, except: [:show]

	def index
		p "****#{current_user.name}"
	end

	def show
		@user = User.find_by(login: params[:login])
		page_not_found unless @user.present?		
	end
end
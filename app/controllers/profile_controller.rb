class ProfileController < FullController
	
	before_action :require_authentication, except: [:show]
	before_action :find_user_by_login, only: [:show, :follow, :unfollow]

	def index		
		@user = current_user	
		tweets		    
	end

	def show				
		tweets		
	end
	
	def create_tweet		
		current_user.tweet!(params[:tweet])
		redirect_to action: :index
	end

	def follow		
		current_user.follow!(@user)		
		redirect_to show_profile_path(@user.login)
	end

	def unfollow		
		current_user.unfollow!(@user)		
		redirect_to show_profile_path(@user.login)
	end

	def users
		name = params[:name] || ''
		name.gsub!('@', '')	
		if name.present?	
			@users = User.where("name LIKE :name or login LIKE :name", name: "#{name}%").limit(20)
		else
			@users = []
		end
		respond_to do |format|
  			format.json { render json: @users, :only => [:login] }
  			format.html { redirect_to root_path }
		end  
	end

	private

	def tweets
		@tweets = Tweet
		.where(user_id:@user.id)
		.most_recent
		.paginate(:per_page => 5, :page => params[:page])		
	end

	def find_user_by_login
		@user = User.find_by(login: params[:login])
		page_not_found unless @user.present?
	end
end
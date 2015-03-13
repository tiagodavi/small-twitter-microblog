class UserSession

	include ActiveModel::Model

	attr_accessor :login, :password

	validates_presence_of :login, :password

	def initialize(session, attributes={})
		@session = session
		@login = attributes[:login]
		@password = attributes[:password]
	end

	def authenticate!
		user = User.authenticate(@login, @password)
		if user.present?
			register(user)			
		else			
			false
		end
	end

	def register(user)
		@session[:user_id] = user.id
	end

	def current_user
		User.find(@session[:user_id])
	end

	def user_signed_in?
		@session[:user_id].present?
	end

	def destroy
		@session[:user_id] = nil
	end
end
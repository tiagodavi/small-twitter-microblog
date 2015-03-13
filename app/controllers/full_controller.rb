class FullController < ApplicationController
	
	def require_authentication
		unless user_signed_in?
			redirect_to root_path			
		end
	end

end
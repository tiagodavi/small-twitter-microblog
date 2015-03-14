module ApplicationHelper
	def page_title(page_title)
  		content_for(:page_title) { page_title }
	end
	def button_follow(user)
		content_for(:button_following) { link_to '<i class="glyphicon glyphicon-user"></i> Seguir'.html_safe, follow_profile_path(user.login), class:'btn btn-primary btn-xs' }
	end
	def button_unfollow(user)
		content_for(:button_following) { link_to '<i class="glyphicon glyphicon-user"></i> Parar de seguir'.html_safe, unfollow_profile_path(user.login), class:'btn btn-danger btn-xs' }
	end
	def error_tag(model, attribute)
		if model.errors.has_key? attribute
			content_tag(:div,model.errors[attribute].first,class: 'error-message') 										
		end
	end
	def when_happened(date)
		"Há #{time_ago_in_words(date)} - #{date.strftime("%d %b. %Y")}"
	end
end

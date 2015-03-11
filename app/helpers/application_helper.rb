module ApplicationHelper
	def page_title(page_title)
  		content_for(:page_title) { page_title }
	end
	def error_tag(model, attribute)
		if model.errors.has_key? attribute
			content_tag(:div,model.errors[attribute].first,class: 'error-message') 										
		end
	end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: "helabs", password: "helabs"

  delegate :current_user, :user_signed_in?, to: :user_session
  helper_method :current_user, :user_signed_in?

  def user_session(attributes={})
	 UserSession.new(session, attributes)
  end

  def page_not_found
    respond_to do |format|
      format.html { render template: 'shared/page_not_found', layout: 'layouts/application', status: 404 }
      format.all  { render nothing: true, status: 404 }
    end
  end
end

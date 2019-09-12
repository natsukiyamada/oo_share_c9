class ApplicationController < ActionController::Base
helper_method :current_user, :signed_in?
before_action :login_required

private

	def current_user
		current_user = current_user || User.find_by(id: session[:user_id]) if session[:user_id]
	end

	def login_required
		redirect_to root_path unless current_user
	end
	
	def signed_in?
      current_user
    end
    
end


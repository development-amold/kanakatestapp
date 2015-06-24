class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	before_action :configure_permitted_parameters, if: :devise_controller?
	protect_from_forgery with: :exception

	def new_session_path(scope)
		new_user_session_path
	end

	def redirect_user
	  redirect_to '/404'
	end	

 protected 

	def configure_permitted_parameters
		devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:email,:name, :password, :password_confirmation) }
		devise_parameter_sanitizer.for(:sign_in) { |u| u.permit(:email,:name,:password,) }
		devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:email,:name,:password,:password_confirmation, :current_password,:image) }
	end

	def after_sign_in_path_for(resource)
	 	edit_user_registration_path
	end


end

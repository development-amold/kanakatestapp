class ApplicationController < ActionController::Base
	# Prevent CSRF attacks by raising an exception.
	# For APIs, you may want to use :null_session instead.
	before_action :configure_permitted_parameters, if: :devise_controller?
	# before_action :authenticate_user!
	protect_from_forgery with: :exception

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

	# def after_sign_in_path_for(resource)
	#  	edit_user_registration_path
	# end

# https://www.facebook.com/logout.php?next=http://example.com&access_token=xxx

end

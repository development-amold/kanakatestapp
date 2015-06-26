class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_action :verify_authenticity_token
    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
             sign_in_and_redirect @user, :event => :authentication
            # sign_in @user
            # redirect_to edit_user_registration_path
            set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
            Rails.logger.info "----@user-------------------------#{@user.inspect}---"
            session["devise.facebook_data"] = request.env["omniauth.auth"]  #facebook session
            flash[:notice] = "Email required for facebook login"
            redirect_to new_user_registration_path
        end
    end

end
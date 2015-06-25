class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
    skip_before_filter :verify_authenticity_token
    def facebook
        # if request.env["omniauth.auth"].info.email.blank?
        #     redirect_to "/users/auth/facebook?auth_type=rerequest&scope=email"
        # else
            @user = User.from_omniauth(request.env["omniauth.auth"])
            if @user.persisted?
                sign_in @user
                redirect_to edit_user_registration_path
                set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
            else
                Rails.logger.info "----@user-------------------------#{@user.inspect}---"
                session["devise.facebook_data"] = request.env["omniauth.auth"]  #facebook session
                redirect_to new_user_registration_path
            end
        # end
    end

end
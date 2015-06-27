class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController

    def facebook
        @user = User.from_omniauth(request.env["omniauth.auth"])
        if @user.persisted?
          session[:fb_token] =  request.env["omniauth.auth"]["credentials"]["token"]
          sign_in_and_redirect @user, :event => :authentication #this will throw if @user is not activated
          set_flash_message(:notice, :success, :kind => "Facebook") if is_navigational_format?
        else
          session["devise.facebook_data"] = request.env["omniauth.auth"]
          flash[:notice] = "Facebook account must have email"  #---facebook with only phone number not allow
          redirect_to new_user_registration_url
        end
    end

  def failure
    super
  end

  protected

 def after_omniauth_failure_path_for(scope)
    super(scope)
  end
end

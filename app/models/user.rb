class User < ActiveRecord::Base
    devise :database_authenticatable, :registerable,:recoverable, :trackable, :validatable, :omniauthable,:omniauth_providers => [:facebook]

   validates :name,:presence => true      
   mount_uploader :image,UserimageUploader

	def self.from_omniauth(auth)
        where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
            user.email = auth.info.email
            user.password = Devise.friendly_token[0,20]
            user.name = auth.info.name   
            user.remote_image_url = auth.info.image.gsub('http:','https:')  #replaced http to https because this is secure image from Facebook 
        end
	end

  def self.new_with_session(params, session)
    super.tap do |user|
        if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
            user.email = data["email"] if user.email.blank?
        end
    end
  end

end

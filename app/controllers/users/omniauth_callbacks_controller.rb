class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :store_location
def self.provides_callback_for(provider)
    class_eval %Q{
      def #{provider}
        @user = User.find_for_oauth(env["omniauth.auth"], current_user)
        logger.info("\n\n\n from find: #{@user.try(:id)}\n\n\")
        if @user.persisted?
          sign_in_and_redirect @user, event: :authentication
          set_flash_message(:success, :success, kind: "#{provider}".capitalize) if is_navigational_format?
        else
          session["devise.#{provider}_data"] = env["omniauth.auth"]
          redirect_to new_user_registration_url
        end
      end
    }
  end

  [:twitter, :facebook, :github, :vkontakte, :google].each do |provider|
    provides_callback_for provider
  end

  def after_sign_in_path_for(resource)
    restore_location_or_root
    #if resource.email_verified?
    #  super resource
    #else
    #  finish_signup_path(resource)
    #end
  end
end

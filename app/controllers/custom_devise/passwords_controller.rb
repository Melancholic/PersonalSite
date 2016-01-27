class CustomDevise::PasswordsController <  Devise::PasswordsController
    skip_before_action :store_location
    protected
    def after_sending_reset_password_instructions_path_for(resource_name)
        restore_location_or_root
    end
    def after_resetting_password_path_for(resource_name)
        restore_location_or_root
    end
end

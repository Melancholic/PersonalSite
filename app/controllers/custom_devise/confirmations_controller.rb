class CustomDevise::ConfirmationsController <  Devise::ConfirmationsController
    skip_before_action :store_location
    protected
    def after_confirmation_path_for(resource_name, resource)
        restore_location_or_root
    end
    def after_resending_confirmation_instructions_path_for(resource_name)
        restore_location_or_root
    end

end

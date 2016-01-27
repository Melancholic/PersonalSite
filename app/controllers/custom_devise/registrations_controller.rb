class CustomDevise::RegistrationsController < Devise::RegistrationsController
    skip_before_action :store_location
    respond_to :html, :js, :json

    protected
    def after_sign_up_path_for(resource)
        restore_location_or_root
    end

    def after_update_path_for(resource)
        restore_location_or_root
    end

end
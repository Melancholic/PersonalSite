class CustomDevise::SessionsController < Devise::SessionsController
    skip_before_action :store_location
    respond_to :html, :json
    def destroy
        previous_url = session[:previous_url] 
        super  
        session[:previous_url] = previous_url
    end
    def create
        previous_url = session[:previous_url] 
        super  
        session[:previous_url] = previous_url
    end
    protected
    def after_sign_in_path_for(resource)
        restore_location_or_root
    end

    def after_sign_out_path_for(resource)
        restore_location_or_root
    end
end
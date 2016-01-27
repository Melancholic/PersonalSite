class CustomDevise::ConfirmationsController <  Devise::ConfirmationsController
    protected
    def after_confirmation_path_for(resource_name, resource)
       blog_root_page_path
   end
   def after_resending_confirmation_instructions_path_for(resource_name)
       blog_root_page_path
   end

end

class CustomDevise::PasswordsController <  Devise::PasswordsController
protected
    def after_sending_reset_password_instructions_path_for(resource_name)
        blog_root_page_path
    end
    def after_resetting_password_path_for(resource_name)
        blog_root_page_path
    end
end

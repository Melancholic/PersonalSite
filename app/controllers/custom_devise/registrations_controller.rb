class CustomDevise::RegistrationsController < Devise::RegistrationsController
  respond_to :html, :js, :json

  protected
  def after_sign_up_path_for(resource)
    blog_root_page_path
  end

  def after_update_path_for(resource)
      blog_root_page_path
  end

end
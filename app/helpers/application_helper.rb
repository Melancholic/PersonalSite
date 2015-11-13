module ApplicationHelper
  def set_i18n
    #Custom user param
    locale=  session[:locale] unless  session[:locale].nil?
    #Default user param
    #locale ||= current_user.locale if signed_in?
    I18n.locale=locale unless locale.nil?
  end
end

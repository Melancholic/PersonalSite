module ApplicationHelper
    def full_title(page_title="")
        base_title= "Nagorny Andrey"
        if (page_title.empty?)
          base_title
        else
          "#{base_title} | #{page_title}"
        end
    end

    def set_i18n
        #Custom user param
        locale=  session[:locale] unless  session[:locale].nil?
        #Default user param
        #locale ||= current_user.locale if signed_in?
        I18n.locale=locale unless locale.nil?
    end
end

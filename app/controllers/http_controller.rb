class HttpController < ApplicationController
    before_action :set_i18n
    skip_before_action :set_i18n, only: [:set_custom_locale]

    def set_custom_locale
      if (params.has_key?(:locale) && LANGUAGES.map(&:second).include?(params[:locale]))
        session[:locale]=params[:locale];
      else
        flash[:error]="Uncorrect locale!"
      end
      respond_to do |f|
        f.js { render 'set_custom_locale.js'}
      end
  end
end

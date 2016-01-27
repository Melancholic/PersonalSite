class BlogController < HttpController
    include BlogHelper
    before_action :email_verified?
    before_action :store_location
	def rootpage
	end

    def testaction
    end
	
    private
    def store_location
        return unless request.get? 
        session[:previous_url]=request.path
    end
    def email_verified?
        if(user_signed_in?)
            @need_verif_form=(!current_user.email_verified?) && (current_user.unconfirmed_email.nil?)
        end
    end

end

module BlogHelper
    def restore_location_or_root
        session[:previous_url] || blog_root_page_path
    end
    def render_404
        respond_to do |format|
            format.html { render :file => "#{Rails.root}/public/404", :layout => false, :status => :not_found }
            format.xml  { head :not_found }
            format.any  { head :not_found }
        end
    end
end

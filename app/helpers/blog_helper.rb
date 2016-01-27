module BlogHelper
    def restore_location_or_root
        session[:previous_url] || blog_root_page_path
    end
end

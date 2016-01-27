class BlogController < HttpController
	def rootpage
	end
	
	protected
	def after_sign_out_path_for(resource)
	    blog_root_page_path
	end

end

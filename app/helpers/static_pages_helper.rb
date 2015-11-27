module StaticPagesHelper
	def template_image arg, param={}
		image_tag("creative_template/#{arg}", param)
	end

	def contact_path 
		root_path anchor: "contact"
	end
	def about_path 
		root_path anchor: "about"
	end
	def services_path
		root_path anchor: "services"
	end
	def portfolio_path
		root_path anchor: "portfolio"
	end
	
	def contact_url 
		root_url anchor: "contact"
	end
	def about_url 
		root_url anchor: "about"
	end
	def services_url
		root_url anchor: "services"
	end
	def portfolio_url
		root_url anchor: "portfolio"
	end

end

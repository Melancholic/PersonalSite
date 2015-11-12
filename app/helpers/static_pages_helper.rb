module StaticPagesHelper
	def template_image arg, param={}
		image_tag("creative_template/#{arg}", param)
	end

end

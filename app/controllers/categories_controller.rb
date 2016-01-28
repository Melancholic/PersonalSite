class CategoriesController < BlogController
    def index
        @categories = Category.all.limit(30)
        respond_to do |format|
            format.html {redirect_to blog_root_page_path}
            format.json { render json: @categories.map{|x| x.as_json(only:[:id, :title, :parrent_id]).merge(url: category_url(x) )} }
        end
    end
end

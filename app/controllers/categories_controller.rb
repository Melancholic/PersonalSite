class CategoriesController < BlogController
    include CategoryHelper
    before_action :set_category, only: [:show, :edit, :update, :destroy]

    def index
        @category = Category.find_by_id(params[:id]);
        @categories = Category.rooted.map{|x| build_tree x} #Category.all.limit(30)
        respond_to do |format|
            format.html {redirect_to blog_root_page_path}
            #format.json { render json: @categories.map{|x| x.as_json(only:[:id, :title, :parrent_id]).merge(url: category_url(x) )} }
            format.json {render json: @categories.map{|x,v| x.as_json()}}
        end
    end

    def show
        @articles = Article.by_category(@category).page params[:page]
    end

private


    def set_category
        @category = Category.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
        params.require(:category).permit(:title, :description, :weight)
    end
end

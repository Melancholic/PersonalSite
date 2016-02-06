class ArticlesController < BlogController
    before_action :set_category, only: [:index,:show, :edit, :update, :destroy]
    before_action :set_article, only: [:show, :edit, :update, :destroy]
    def index
        @articles= @category.articles
    end
    def show
        render_404 if @article.nil?
    end

    def edit
        authorize! :edit, @article
    end

    def update
        if(@article.update_attributes(article_params))
            redirect_to [@category, @article]
        else
            render 'edit'
        end
    end

    private


    def set_category
        @category = Category.find(params[:category_id])
    end
    def set_article
        @article = Article.where(id:params[:id], category:@category).first
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def article_params
        logger.info "\n\n\n #{params}\n\n"
        params.require(:article).permit(:id, :title, :body, :category_id, :user_id)
    end
end

class ArticlesController < BlogController
    before_action :set_category, except:[:new,:create]
    load_and_authorize_resource
    #before_action :set_article, only: [:show, :edit, :update, :destroy]
    def new
        @article = Article.new()
    end

    def create
        @article =Article.new(article_params);
        @article.author=current_user;
        if(@article.save)
            redirect_to [@article.category, @article]
        else
            render 'new', :error => "An Error Occurred! #{@article.errors[:base].to_s}"
        end
    end

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

    def destroy
        title= @article.title
        if (@article.destroy)
            url = @category if restore_location_or_root == category_article_path(@category, @article)
            flash[:info]="Article #{title} has been deleted!" ;
            if (url.present?)
                redirect_to url
            else
                redirect_to :back
            end
        else
            redirect_to :back, :error => "An Error Occurred! #{@article.errors[:base].to_s}"
        end
    end

    private
    def set_category
        @category = Category.find(params[:category_id])
    end
    def set_article
        @article = Article.where(id:params[:id], category:@category).first
    end

    def article_params
        logger.info "\n\n\n #{params}\n\n"
        params.require(:article).permit(:title, :body, :category_id)
    end
end

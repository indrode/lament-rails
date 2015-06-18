class ArticlesController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_AUTH_USER'], password: ENV['HTTP_AUTH_PW']
  before_filter :set_article, only: [:edit, :update, :destroy]
  after_filter :invalidate_cache, only: [:create, :update]

  def index
    @articles = Article.ordered.all
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def create
    @article = Article.new(article_params)
    if @article.save
      redirect_to articles_url, notice: 'Article was successfully created'
    else
      render :new
    end
  end

  def update
    if @article.update(article_params)
      redirect_to articles_url, notice: 'Article was successfully updated'
    else
      render :edit
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_article
    @article = Article.find_by_number(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:enabled, :number, :title, :blurb, :category_id, :copy, :posted_at)
  end

  def invalidate_cache
    expire_page controller: :home, action: 'index'
    expire_page controller: :home, action: 'show', number: @article.to_param
    expire_page controller: :categories, action: 'show', title: @article.category.title
  end
end

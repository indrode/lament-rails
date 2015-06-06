class ArticlesController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_AUTH_USER'], password: ENV['HTTP_AUTH_PW']
  before_action :set_article, only: [:edit, :update, :destroy]

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
    @article = Article.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def article_params
    params.require(:article).permit(:enabled, :number, :title, :blurb, :category, :copy, :posted_at)
  end
end

class HomeController < ApplicationController
  caches_page :index, :show
  before_filter :set_query

  def index
    @categories = Category.includes(:articles).all
    @recent = Category.recent
  end

  def show
    @article = Article.find_by_number(params[:number])
  end

  def results
    @results = Article.search(@query)
  end

  private

  def set_query
    @query = params[:query] || params[:highlight]
  end
end

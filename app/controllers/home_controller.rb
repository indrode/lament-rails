class HomeController < ApplicationController
  caches_page :index, :show

  def index
    @article = Article.enabled.ordered.first
  end

  def show
    @article = Article.find_by_number(params[:number])
  end
end

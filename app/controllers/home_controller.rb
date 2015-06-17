class HomeController < ApplicationController
  caches_page :index, :show

  def index
    @categories = Category.includes(:articles).all
  end

  def show
    @article = Article.find_by_number(params[:number])
  end
end

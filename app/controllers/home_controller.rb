class HomeController < ApplicationController
  def index
    @article = Article.enabled.ordered.first
  end

  def show
    @article = Article.find(params[:id])
  end
end

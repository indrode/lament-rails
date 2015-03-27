class HomeController < ApplicationController
  def index
    @article = Article.ordered.first
  end
end

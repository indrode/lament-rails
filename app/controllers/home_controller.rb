class HomeController < ApplicationController
  def index
    @article = Article.enabled.ordered.first
  end
end

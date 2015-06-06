class HomeController < ApplicationController
  before_filter :load_article, only: :show

  def index
    @article = Article.enabled.ordered.first
  end

  def show
  end

  private

  def load_article
    @article = Article.find_by_number(params[:number])
    render_404 unless @article
  end
end

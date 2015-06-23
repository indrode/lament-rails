class CategoriesController < ApplicationController
  caches_page :show

  def show
    @categories = Category.includes(:articles).all
    @category = Category.find_by_title(params[:title])
  end
end

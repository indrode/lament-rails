class CategoriesController < ApplicationController
  caches_page :show

  def show
    @category = Category.find_by_title(params[:title])
  end
end

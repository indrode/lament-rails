class Admin::ArticlesController < ApplicationController
  http_basic_authenticate_with name: ENV['HTTP_AUTH_USER'], password: ENV['HTTP_AUTH_PW']

  def index
    @articles = Article.all
  end
end

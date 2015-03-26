class HomeController < ApplicationController
  def index
    @article = {
      title: 'Hello World',
      date: Time.now.strftime('%B %e, %Y'),
      copy: '<p>Lorem ipsum hello world.<p>'.html_safe
    }
  end
end

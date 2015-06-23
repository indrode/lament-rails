class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def routing_error
    # TODO: implement flash message
    redirect_to controller: :home, action: :index, status: 302
  end

end

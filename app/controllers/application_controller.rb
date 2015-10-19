class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :null_session

  def authenticate
    # This tutorial recommends receiving API keys in
    # headers because of security reasons
    # http://blog.joshsoftware.com/2014/05/08/implementing-rails-apis-like-a-professional/
    api_key = request.headers["Book-Duets-Key"]
    @user = User.find_by(api_key:api_key)

    unless @user
      # This should return a 401 error
      head status: :unauthorized
      return false
    end
  end
end

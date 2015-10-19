class UsersController < ApplicationController

  def new
    email = params["email"]

    User.create(email:email)
    user = User.find_by(email:email)
    api_key = user.api_key

    render json: {message: "Here is your unique API key.", api_key: api_key }
  end
end

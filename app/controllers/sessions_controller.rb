class SessionsController < ApplicationController
  include Authenticable
  before_action :authorize, only: [:logout]

  def create
    user = User.find_or_create_from_oauth(request.env['omniauth.auth'])
    user.generate_auth_token
    user.save
    render json: user
  end

  def logout
    user = User.find(params[:id]) 
    user.generate_auth_token
    user.save
    render json: {success: 'User successfully logged out'}, status: 200
  end
end

class UsersController < ApplicationController
  include Authenticable
  before_action :set_user, except: [:index]
  before_action :authenticate_with_token

  def index
    @users = User.all
    render json: @users
  end

  def show
    render json: @user
  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  def destroy
    @user.destroy
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.permit(:uid, :provider, :name, :email, :password, :password_confirmation, :oauth_token, :oauth_token_expires_at)
    end
end

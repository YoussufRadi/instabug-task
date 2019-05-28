
class AuthenticationController < ApplicationController
  require 'json_web_token'
  before_action :authorize_request, except: :login

  # POST /auth/login
  def login
    @user = User.find_by_name(params[:name])
    if @user
      token = JsonWebToken.encode(user_id: @user.id)
      time = Time.now + 24.hours.to_i
      render json: { token: token, exp: time.strftime("%m-%d-%Y %H:%M"),
                     username: @user.name }, status: :ok
    else
      render json: { error: 'unauthorized' }, status: :unauthorized
    end
  end

  private

  def login_params
    params.permit(:name)
  end

end
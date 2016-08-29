module Authenticable
  def current_user
    @current_user ||= User.find_by(prynt_auth_token: request.headers['Authorization'])
  end

  def authenticate_with_token
    render json: {error: 'Invalid Authorization Token'}, status: :unauthorized unless current_user.present?
  end
end

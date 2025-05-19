module AuthenticateUser
  extend ActiveSupport::Concern

  included do
    before_action :authenticate_request
  end

  def authenticate_request
    header = request.headers['Authorization']
    token = header&.split(' ')&.last

    if token.blank?
      return render json: { error: 'Missing token' }, status: :unauthorized
    end

    secret_key = "qwertyuiop"
    decoded = JWT.decode(token, secret_key, true, algorithm: 'HS256')[0]
    @current_user = User.find_by(id: decoded['id'])

    unless @current_user
      render json: { error: 'User not found' }, status: :unauthorized
    end

  rescue JWT::ExpiredSignature
    render json: { error: 'Token has expired' }, status: :unauthorized
  rescue JWT::DecodeError
    render json: { error: 'Invalid token' }, status: :unauthorized
  end
end


class Api::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def signup
    user = User.create!(signup_params)
    render json: { token: generate_jwt(user), user: user.slice(:id, :email, :role, :dob) }
  end

  def login
    user = User.find_by(email: params[:email], role: params[:role])
    if user&.valid_password?(params[:password])
      render json: { token: generate_jwt(user), user: user.slice(:id, :email, :role, :dob) }
    else
      render json: { error: 'Invalid credentials' }, status: :unauthorized
    end
  end

  private

  def signup_params
    params.permit(:email, :password, :role, :dob)
  end

  def generate_jwt(user)
    payload = {
      id: user.id,
      role: user.role,
      exp: 24.hours.from_now.to_i
    }
    secret_key = "qwertyuiop"
    JWT.encode(payload, secret_key, 'HS256')
  end
end

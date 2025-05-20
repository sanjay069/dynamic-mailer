# class Api::AuthController < ApplicationController
#   skip_before_action :verify_authenticity_token

#   def signup
#     user = User.create!(signup_params)
#     render json: { token: generate_jwt(user), user: user.slice(:id, :email, :role, :dob) }
#   end

#   def login
#     user = User.find_by(email: params[:email], role: params[:role])
#     if user&.valid_password?(params[:password])
#       render json: { token: generate_jwt(user), user: user.slice(:id, :email, :role, :dob) }
#     else
#       render json: { error: 'Invalid credentials' }, status: :unauthorized
#     end
#   end

#   private

#   def signup_params
#     params.permit(:email, :password, :role, :dob)
#   end

#   def generate_jwt(user)
#     payload = {
#       id: user.id,
#       role: user.role,
#       exp: 24.hours.from_now.to_i
#     }
#     secret_key = "qwertyuiop"
#     JWT.encode(payload, secret_key, 'HS256')
#   end
# end

# class Api::AuthController < ApplicationController
#   skip_before_action :verify_authenticity_token

#   def signup
#     # Look up language by name instead of id

#     language = Language.find_by(language_name: params[:language], status: "enable")

#     unless language
#       return render json: { error: "Selected language is not enabled or does not exist" }, status: :unprocessable_entity
#     end

#     # Merge the resolved language_id into user creation
#     user = User.create!(signup_params.merge(language_id: language.id))

#     render json: {
#       token: generate_jwt(user),
#       user: user.slice(:id, :email, :role, :dob).merge(language: language.language_name)
#     }
#   end

#   def login
#     user = User.find_by(email: params[:email], role: params[:role])
#     if user&.valid_password?(params[:password])
#       render json: {
#         token: generate_jwt(user),
#         user: user.slice(:id, :email, :role, :dob).merge(language: user.language&.language_name)
#       }
#     else
#       render json: { error: 'Invalid credentials' }, status: :unauthorized
#     end
#   end

#   private

#   def signup_params
#     params.permit(:email, :password, :role, :dob)
#   end

#   def generate_jwt(user)
#     payload = {
#       id: user.id,
#       role: user.role,
#       exp: 24.hours.from_now.to_i
#     }
#     secret_key = "qwertyuiop"
#     JWT.encode(payload, secret_key, 'HS256')
#   end
# end

class Api::AuthController < ApplicationController
  skip_before_action :verify_authenticity_token

  def signup
    language = Language.joins(:templates).where(language_name: params[:language], status: "enable", templates: { title: params[:title] }).distinct.first

    unless language
      return render json: { error: "Selected language with the specified template title is not enabled or does not exist" }, status: :unprocessable_entity
    end

    user = User.create!(signup_params.merge(language_id: language.id))

    render json: {
      token: generate_jwt(user),
      user: user.slice(:id, :email, :role, :dob).merge(language: language.language_name, title: params[:title])
    }
  end

  def login
    user = User.find_by(email: params[:email], role: params[:role])
    if user&.valid_password?(params[:password])
      language = user.language
      title = language&.templates&.first&.title

      render json: {
        token: generate_jwt(user),
        user: user.slice(:id, :email, :role, :dob)
                  .merge(language: language&.language_name, title: title)
      }
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
# class Api::EmailController < ApplicationController
#   include AuthenticateUser
#   skip_before_action :verify_authenticity_token

#   def send_email
#     unless @current_user&.role == "Consumer"
#       return render json: { error: "Only consumers are allowed to send emails" }, status: :forbidden
#     end

#     authorize! :read, Template

#     template = Template.find(params[:template_id])
#     language = Language.find(params[:language_id])
    
#     if language.status != "enable"
#       render json: { error: "Selected language is disabled" }, status: :unprocessable_entity
#     else
#       UserMailer.custom_email(template, @current_user).deliver_later
#       render json: { message: "Email sent successfully!" }
#     end
#   end
# end
class Api::EmailController < ApplicationController
  include AuthenticateUser
  skip_before_action :verify_authenticity_token

  def send_email
    unless @current_user&.role == "Consumer"
      return render json: { error: "Only consumers are allowed to send emails" }, status: :forbidden
    end

    authorize! :read, Template

    begin
      template = Template.find_by(subject: params[:subject], title: params[:title])
      if template.nil?
        return render json: { error: "Template not found" }, status: :not_found
      end

      UserMailer.custom_email(template, @current_user).deliver_later
      render json: { message: "Email sent successfully!" }
    rescue => e
      render json: { error: "Something went wrong: #{e.message}" }, status: :internal_server_error
    end
  end
end

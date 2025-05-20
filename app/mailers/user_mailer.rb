class UserMailer < ApplicationMailer
  def custom_email(template, user)
    @language = template.language 
    @title = template.title
    @body = template.body
    mail(to: user.email, language: @language)
  end
end

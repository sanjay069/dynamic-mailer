class UserMailer < ApplicationMailer
  def custom_email(template, user)
    @subject = template.subject
    @title = template.title
    @body = template.body
    mail(to: user.email, subject: @subject)
  end
end

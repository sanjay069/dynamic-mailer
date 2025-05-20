class Api::LanguagesController < ApplicationController
  include AuthenticateUser

  def index
    authorize! :read, Language
    render json: Language.where(status: 'enable')
  end
end

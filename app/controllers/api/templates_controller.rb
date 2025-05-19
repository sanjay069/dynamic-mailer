class Api::TemplatesController < ApplicationController
  include AuthenticateUser

  def index
    authorize! :read, Template
    render json: Template.all
  end
end

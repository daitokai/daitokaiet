class Api::ApplicationController < ApplicationController
  protect_from_forgery with: :null_session

  layout 'application_mobile'

  def current_user
    User.find(doorkeeper_token.resource_owner_id)
  end
end

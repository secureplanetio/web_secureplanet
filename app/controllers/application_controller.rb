class ApplicationController < ActionController::Base
  include Pundit
  protect_from_forgery with: :exception

  private

  def current_user
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end

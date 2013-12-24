class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :tweet_service

  private

    def tweet_service
      @service ||= TweetService.new(current_user).tap do |service|
        current_user.subscribe(service) if current_user
      end
    end
end

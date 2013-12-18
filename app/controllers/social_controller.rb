class SocialController < ApplicationController
  before_action :authenticate_user!
  def index
    @date = params[:date] || Date.today
    @date = @date.to_date
  end
end

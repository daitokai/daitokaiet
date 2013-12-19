class SocialController < ApplicationController
  before_action :authenticate_user!

  def index
  end

  def show
    @user = User.find_by(name: params[:name])
  end
end

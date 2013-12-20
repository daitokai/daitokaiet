class SocialController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: [:follow, :unfollow]

  def index
  end

  def show
    @user = User.find_by(name: params[:name])
  end

  def follow
    current_user.follow(@user)
    redirect_to show_social_url(name: @user.name), notice: 'フォローしました。'
  end

  def unfollow
    current_user.unfollow(@user)
    redirect_to show_social_url(name: @user.name), notice: 'フォローを外しました。'
  end

  private
  def set_user
    @user = User.find(params[:id])
  end
end

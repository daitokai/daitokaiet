module Api::V1
  class SocialController < Api::ApplicationController
    before_action :doorkeeper_authorize!
    before_action :set_user, only: [:follow, :unfollow]

    def index
    end

    def show
      @user = User.where(name: params[:name]).first
      respond_to do |format|
        format.html do
          if @user.blank?
            render 'social/not_found'
          else
            render
          end
        end
        format.json do
          if @user.blank?
            head :no_content
          else
            render
          end
        end
      end
    end

    def search
      @users = User.where.not(id: current_user.id).search(params[:q]).result.sample(30)
      respond_to do |format|
        format.html do
          if @users.blank?
            render 'social/not_found'
          else
            render
          end
        end
        format.json do
          if @users.blank?
            head :no_content
          else
            render
          end
        end
      end
    end

    def follow
      current_user.follow(@user)
      respond_to do |format|
        format.js { render }
        format.json { head :no_content }
      end
    end

    def unfollow
      current_user.unfollow(@user)
      respond_to do |format|
        format.js { render }
        format.json { head :no_content }
      end
    end

    private
    def set_user
      @user = User.find(params[:id])
    end
  end
end
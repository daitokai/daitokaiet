# -*- coding: utf-8 -*-
class Users::RegistrationsController < Devise::RegistrationsController

  def new
    redirect_to root_path
  end

  def create
    redirect_to root_path
  end

  def build_resource(hash=nil)
    hash[:uid] = User.create_unique_string
    super
  end

  def update
    current_user.update(users_params)
    if current_user.update_first_step!
      redirect_to new_record_url, notice: '次に今日の体重を記録しましょう！！'
    else
      flash.now[:notice] = '更新しました。'
      render :edit
    end
  end

  private
  def users_params
    params.require(:user).permit(:goal)
  end
end

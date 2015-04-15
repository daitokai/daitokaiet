module Api::V1
  class UsersController < Api::ApplicationController
    before_action doorkeeper_authorize!

    def show
    end

    def edit
    end

    def update
      respond_to do |format|
        if current_user.update(users_params)
          format.html do
            if current_user.update_first_step!
              redirect_to new_api_v1_record_url, notice: '次に今日の体重を記録しましょう！！'
            else
              flash.now[:notice] = '更新しました。'
              render :edit
            end
          end
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: current_user.errors, status: :unprocessable_entity }
        end
      end
    end

    private
    def users_params
      params.require(:user).permit(:goal)
    end
  end
end
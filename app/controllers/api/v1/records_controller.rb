module Api::V1
  class RecordsController < Api::ApplicationController
    doorkeeper_for :all
    before_action :set_record, only: [:edit, :update, :destroy]

    # GET /api/v1/records
    # GET /api/v1/records.json
    def index
      @records = current_user.records.order(target_date: :desc)
    end

    # GET /api/v1records/new
    def new
      @record = current_user.records.build
    end

    # GET /api/v1/records/1/edit
    def edit
    end

    # POST /api/v1/records
    # POST /api/v1/records.json
    def create
      @record = current_user.records.build(record_params)
      @record.subscribe(@service)
      respond_to do |format|
        if @record.save
          format.html do
            if current_user.update_second_step!
              #redirect_to social_url, notice: '上のテキストボックスから友達を探してフォローしましょう！！'
              redirect_to api_v1_records_url(access_token: params[:access_token]), notice: '登録しました'
            else
              redirect_to api_v1_records_url(access_token: params[:access_token]), notice: '登録しました'
            end
          end
          format.json { render 'api/v1/records/show' }
        else
          format.html { render action: 'new' }
          format.json { render json: @record.errors, status: :unprocessable_entity }
        end
      end
    end

    # PATCH/PUT /api/v1/records/1
    # PATCH/PUT /api/v1/records/1.json
    def update
      respond_to do |format|
        if @record.update(record_params)
          format.html { redirect_to api_v1_records_url(access_token: params[:access_token]), notice: '更新しました' }
          format.json { head :no_content }
        else
          format.html { render action: 'edit' }
          format.json { render json: @record.errors, status: :unprocessable_entity }
        end
      end
    end

    # DELETE /api/v1/records/1
    # DELETE /api/v1/records/1.json
    def destroy
      @record.destroy
      respond_to do |format|
        format.html { redirect_to api_v1_records_url(access_token: params[:access_token]) }
        format.json { head :no_content }
      end
    end

    private
    # Use callbacks to share common setup or constraints between actions.
    def set_record
      @record = current_user.records.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def record_params
      params.require(:record).permit(:target_date, :weight, :comment)
    end
  end

end

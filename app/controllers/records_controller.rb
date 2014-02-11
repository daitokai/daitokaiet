class RecordsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_record, only: [:edit, :update, :destroy]
  before_action :set_records, only: [:index]
  before_action :set_recent_records, only: [:new, :create]

  # GET /records
  def index
  end

  # GET /records/new
  def new
    @record = @records.build
  end

  # GET /records/1/edit
  def edit
  end

  # POST /records
  def create
    @record = @records.build(record_params)
    @record.subscribe(@service)
    if @record.save
      if current_user.update_second_step!
        redirect_to social_url, notice: '上のテキストボックスから友達を探してフォローしましょう！！'
      else
        redirect_to records_url, notice: '登録しました'
      end
    else
      render action: 'new'
    end
  end

  # PATCH/PUT /records/1
  def update
    if @record.update(record_params)
      redirect_to records_url, notice: '更新しました'
    else
      render action: 'edit'
    end
  end

  # DELETE /records/1
  def destroy
    @record.destroy
    redirect_to records_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_records
    @records = current_user.records.order(target_date: :desc)
  end

  def set_recent_records
    @records = set_records.limit(5)
  end

  def set_record
    @record = current_user.records.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def record_params
    params.require(:record).permit(:target_date, :weight, :comment)
  end
end

class Doorkeeper::UserApplicationsController < Doorkeeper::ApplicationsController
  before_action :authenticate_user!

  def index
    @applications = current_user.oauth_applications
  end

  def create
    @application = current_user.oauth_applications.build(application_params)
    if @application.save
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :create])
      redirect_to oauth_application_url(@application)
    else
      render :new
    end
  end

  def update
    if @application.update_attributes(application_params)
      flash[:notice] = I18n.t(:notice, :scope => [:doorkeeper, :flash, :applications, :update])
      respond_with [:oauth, @application]
    else
      render :edit
    end
  end

  private

  def set_application
    @application = current_user.oauth_applications.find(params[:id])
  end

end

class HelpCenter::NotificationsController < HelpCenter::ApplicationController
  before_action :authenticate_user!
  before_action :set_support_thread

  def create
    @support_thread.toggle_subscription(current_user)
    redirect_to help_center.support_thread_path(@support_thread)
  end

  def show
    redirect_to help_center.support_thread_path(@support_thread)
  end

  private

    def set_support_thread
      @support_thread = SupportThread.friendly.find(params[:support_thread_id])
    end
end

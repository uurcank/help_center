class HelpCenter::SupportCategoriesController < HelpCenter::ApplicationController
  before_action :set_category

  def index
    @support_threads = SupportThread.where(support_category: @category) if @category.present?
    @support_threads = @support_threads.pinned_first.sorted.includes(:user, :support_category)
    @pagy, @records = pagy(@support_threads)
    render "help_center/support_threads/index"
  end

  private

    def set_category
      @category = SupportCategory.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to help_center.support_threads_path
    end
end

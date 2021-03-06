class HelpCenter::SupportCategoriesController < HelpCenter::ApplicationController
  before_action :authenticate_user!, only: [:edit, :update, :destroy]
  before_action :set_category, only: [:show, :edit, :update, :destroy]
  before_action :require_mod_or_author_for_thread!, only: [:edit, :update, :destroy]


  def index
  end

  def new
    @category = SupportCategory.new
  end

  def show
  end

  def create
    @category = SupportCategory.new(support_category_params)

    if @category.save
      redirect_to help_center.support_threads_path
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @category.update(support_category_params)
      redirect_to help_center.support_category_path(@category), notice: I18n.t('your_changes_were_saved')
    else
      render action: :edit
    end
  end

  def destroy
    @category.destroy
    redirect_to help_center.support_threads_path, notice: I18n.t('successfully_deleted')
  end

  private

    def set_category
      @category = SupportCategory.friendly.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      redirect_to help_center.support_categories_path, notice: I18n.t('page_not_found')
    end

    def support_category_params
      params.require(:support_category).permit(:name, :color, :position)
    end
end

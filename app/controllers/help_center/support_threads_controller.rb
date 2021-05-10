class HelpCenter::SupportThreadsController < HelpCenter::ApplicationController
  before_action :authenticate_user!, only: [:mine, :participating, :new, :create]
  before_action :set_support_thread, only: [:show, :edit, :update, :destroy]
  before_action :require_mod_or_author_for_thread!, only: [:edit, :update]

  def index
    @support_threads = SupportThread.pinned_first.sorted.includes(:user, :support_category)
    @pagy, @records = pagy(@support_threads)
  end

  def answered
    @support_threads = SupportThread.solved.sorted.includes(:user, :support_category)
    @pagy, @records = pagy(@support_threads)
    render action: :index
  end

  def unanswered
    @support_threads = SupportThread.unsolved.sorted.includes(:user, :support_category)
    @pagy, @records = pagy(@support_threads)
    render action: :index
  end

  def mine
    @support_threads = SupportThread.where(user: current_user).sorted.includes(:user, :support_category)
    @pagy, @records = pagy(@support_threads)
    render action: :index
  end

  def participating
    @support_threads = SupportThread.includes(:user, :support_category).joins(:support_posts).where(support_posts: { user_id: current_user.id }).distinct(support_posts: :id).sorted
    @pagy, @records = pagy(@support_threads)
    render action: :index
  end

  def show
    @support_post = SupportPost.new
    @support_post.user = current_user
  end

  def new
    @support_thread = SupportThread.new
    @support_thread.support_posts.new
  end

  def create
    @support_thread = current_user.support_threads.new(support_thread_params)
    @support_thread.support_posts.each{ |post| post.user_id = current_user.id }

    if @support_thread.save
      HelpCenter::SupportThreadNotificationJob.perform_later(@support_thread)
      redirect_to help_center.support_thread_path(@support_thread)
    else
      render action: :new
    end
  end

  def edit
  end

  def update
    if @support_thread.update(support_thread_params)
      redirect_to help_center.support_thread_path(@support_thread), notice: I18n.t('your_changes_were_saved')
    else
      render action: :edit
    end
  end

  def destroy
    @support_thread.destroy
    redirect_to help_center.support_category_path(@support_thread.support_category), notice: I18n.t('successfully_deleted')
  end

  private

    def set_support_thread
      @support_thread = SupportThread.friendly.find(params[:id])
    end

    def support_thread_params
      params.require(:support_thread).permit(:title, :content, :position, :support_category_id, support_posts_attributes: [:body])
    end
end

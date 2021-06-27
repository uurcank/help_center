class HelpCenter::SupportPostsController < HelpCenter::ApplicationController
  before_action :authenticate_user!
  before_action :set_support_thread
  before_action :set_support_post, only: [:edit, :update, :destroy]
  before_action :require_mod_or_author_for_post!, only: [:edit, :update, :destroy]
  before_action :require_mod_or_author_for_thread!, only: [:solved, :unsolved]

  def create
    @support_post = @support_thread.support_posts.new(support_post_params)
    @support_post.user_id = current_user.id

    if @support_post.save
      HelpCenter::SupportPostNotificationJob.perform_later(@support_post)
      redirect_to help_center.support_thread_path(@support_thread, anchor: "support_post_#{@support_post.id}")
    else
      render template: "help_center/support_threads/show"
    end
  end

  def edit
  end

  def update
    if @support_post.update(support_post_params)
      redirect_to help_center.support_thread_path(@support_thread)
    else
      render action: :edit
    end
  end

  def destroy
    @support_post.destroy!
    redirect_to help_center.support_thread_path(@support_thread)
  end

  def solved
    @support_post = @support_thread.support_posts.find(params[:id])

    @support_thread.support_posts.update_all(solved: false)
    @support_post.update_column(:solved, true)
    @support_thread.update_column(:solved, true)

    redirect_to help_center.support_thread_path(@support_thread, anchor: ActionView::RecordIdentifier.dom_id(@support_post))
  end

  def unsolved
    @support_post = @support_thread.support_posts.find(params[:id])

    @support_thread.support_posts.update_all(solved: false)
    @support_thread.update_column(:solved, false)

    redirect_to help_center.support_thread_path(@support_thread, anchor: ActionView::RecordIdentifier.dom_id(@support_post))
  end

  private 
 
    def set_support_thread
      @support_thread = SupportThread.friendly.find(params[:support_thread_id])
    rescue ActiveRecord::RecordNotFound
      redirect_to help_center.root_path
    end

    def set_support_post
      if is_moderator?
        @support_post = @support_thread.support_posts.find(params[:id])
      else
        @support_post = current_user.support_posts.find(params[:id])
      end
    end

    def support_post_params
      params.require(:support_post).permit(:body)
    end
end

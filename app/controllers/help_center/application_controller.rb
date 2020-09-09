class HelpCenter::ApplicationController < ::ApplicationController
  layout "help_center"

  def page_number
    page = params.fetch(:page, '').gsub(/[^0-9]/, '').to_i
    page = "1" if page.zero?
    page
  end

  def is_moderator_or_owner?(object)
    is_moderator?
  end
  helper_method :is_moderator_or_owner?

  def is_moderator?
    current_user.respond_to?(:moderator) && current_user.moderator? || current_user.respond_to?(:admin) && current_user.admin?
  end
  helper_method :is_moderator?

  def require_mod_or_author_for_post!
    unless is_moderator_or_owner?(@support_post)
      redirect_to_root
    end
  end

  def require_mod_or_author_for_thread!
    unless is_moderator_or_owner?(@support_thread)
      redirect_to_root
    end
  end

  private

  def redirect_to_root
    redirect_to help_center.root_path
  end
end

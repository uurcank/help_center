module HelpCenter::SupportPostsHelper
  # Override this to use avatars from other places than Gravatar
  def avatar_tag(email)
    gravatar_image_tag(email, gravatar: { size: 40 }, class: "rounded avatar")
  end

  def support_category_link(category)
    link_to category.name, help_center.support_category_path(category),
      style: "color: #{category.color}"
  end

  # Override this method to provide your own content formatting like Markdown
  def formatted_content(text)
    simple_format(text)
  end

  def support_post_classes(support_post)
    klasses = ["support-post", "card", "mb-3"]
    klasses << "solved" if support_post.solved?
    klasses << "original-poster" if support_post.user == @support_thread.user
    klasses
  end

  def support_user_badge(user)
    if user.respond_to?(:moderator) && user.moderator?
      content_tag :span, "Mod", class: "badge badge-default"
    end
  end
end

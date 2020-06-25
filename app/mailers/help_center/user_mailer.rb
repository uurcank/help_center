class HelpCenter::UserMailer < ApplicationMailer
  # You can set the default `from` address in ApplicationMailer

  helper HelpCenter::ForumPostsHelper
  helper HelpCenter::Engine.routes.url_helpers

  def new_thread(support_thread, recipient)
    @support_thread = support_thread
    @support_post   = support_thread.support_posts.first
    @recipient    = recipient

    mail(
      to: "#{@recipient.name} <#{@recipient.email}>",
      subject: @support_thread.title
    )
  end

  def new_post(support_post, recipient)
    @support_post   = support_post
    @support_thread = support_post.support_thread
    @recipient    = recipient

    mail(
      to: "#{@recipient.name} <#{@recipient.email}>",
      subject: "New post in #{@support_thread.title}"
    )
  end
end

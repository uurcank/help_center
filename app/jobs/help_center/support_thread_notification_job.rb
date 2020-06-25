class HelpCenter::SupportThreadNotificationJob < ApplicationJob
  include HelpCenter::Engine.routes.url_helpers

  def perform(support_thread)
    send_emails(support_thread) if HelpCenter.send_email_notifications
    send_webhook(support_thread) if HelpCenter.send_slack_notifications
  end

  def send_emails(support_thread)
    support_thread.notify_users.each do |user|
      HelpCenter::UserMailer.new_thread(support_thread, user).deliver_later
    end
  end

  def send_webhook(support_thread)
    slack_webhook_url = Rails.application.secrets.simple_discussion_slack_url
    return if slack_webhook_url.blank?

    support_post = support_thread.support_posts.first
    payload = {
      fallback: "A new discussion was started: <#{support_thread_url(support_thread, anchor: ActionView::RecordIdentifier.dom_id(support_posts))}|#{support_thread.title}>",
      pretext: "A new discussion was started: <#{support_thread_url(support_thread, anchor: ActionView::RecordIdentifier.dom_id(support_posts))}|#{support_thread.title}>",
      fields: [
        {
          title: "Thread",
          value: support_thread.title,
          short: true
        },
        {
          title: "Posted By",
          value: support_post.user.name,
          short: true,
        },
      ],
      ts: support_post.created_at.to_i
    }

    HelpCenter::Slack.new(slack_webhook_url).post(payload)
  end
end

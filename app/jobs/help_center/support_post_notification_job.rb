class HelpCenter::SupportPostNotificationJob < ApplicationJob
  include HelpCenter::Engine.routes.url_helpers

  def perform(support_post)
    send_emails(support_post) if HelpCenter.send_email_notifications
    send_webhook(support_post) if HelpCenter.send_slack_notifications
  end

  def send_emails(support_post)
    support_thread = support_post.support_thread
    users        = support_thread.subscribed_users - [support_post.user]
    users.each do |user|
      HelpCenter::UserMailer.new_post(support_post, user).deliver_later
    end
  end

  def send_webhook(support_post)
    slack_webhook_url = Rails.application.secrets.help_center_slack_url
    return if slack_webhook_url.blank?

    support_thread = support_post.support_thread
    payload = {
      fallback: "#{support_post.user.name} replied to <#{support_thread_url(support_thread, anchor: ActionView::RecordIdentifier.dom_id(support_post))}|#{support_thread.title}>",
      pretext: "#{support_post.user.name} replied to <#{support_thread_url(support_thread, anchor: ActionView::RecordIdentifier.dom_id(support_post))}|#{support_thread.title}>",
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

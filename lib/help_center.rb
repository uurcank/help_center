require 'font-awesome-sass'
require 'friendly_id'
require 'gravatar_image_tag'
require 'will_paginate'

require 'help_center/engine'
require 'help_center/support_user'
require 'help_center/slack'
require 'help_center/version'
require 'help_center/will_paginate'

module HelpCenter
  # Define who owns the subscription
  mattr_accessor :enable_comments
  mattr_accessor :send_email_notifications
  mattr_accessor :send_slack_notifications
  @@send_email_notifications = false
  @@send_email_notifications = true
  @@send_slack_notifications = true

  def self.setup
    yield self
  end
end

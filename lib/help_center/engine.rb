module HelpCenter
  class Engine < ::Rails::Engine
    engine_name 'help_center'

    # Grab the Rails default url options and use them for sending emails & notifications
    config.after_initialize do
      HelpCenter::Engine.routes.default_url_options = ActionMailer::Base.default_url_options
    end
  end
end

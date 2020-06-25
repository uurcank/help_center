module HelpCenter
  module SupportUser
    extend ActiveSupport::Concern

    included do
      has_many :support_threads
      has_many :support_posts
    end
  end
end

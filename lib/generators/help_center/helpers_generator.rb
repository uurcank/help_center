require 'rails/generators'

module HelpCenter
  module Generators
    class HelpersGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../..", __FILE__)

      def copy_views
        directory 'app/helpers', 'app/helpers'
      end
    end
  end
end

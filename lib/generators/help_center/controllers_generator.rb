require 'rails/generators'

module HelpCenter
  module Generators
    class ControllersGenerator < Rails::Generators::Base
      source_root File.expand_path("../../../..", __FILE__)

      def copy_controllers
        directory 'app/controllers/help_center', 'app/controllers/help_center'
      end
    end
  end
end

# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "help_center/version"

Gem::Specification.new do |spec|
  spec.name          = "help_center"
  spec.version       = HelpCenter::VERSION
  spec.authors       = ["Ugurcan Kaya"]
  spec.email         = ["support@pasilobus.com"]

  spec.summary       = %q{A wiki gem for creating documentation & help centers in your Rails app}
  spec.description   = %q{Knowledge Base, User Docs, API Docs, Community discussions and more for Rails apps}
  spec.homepage      = "https://github.com/uurcank/help_center"
  spec.license       = "MIT"

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency 'font-awesome-sass', '>= 5.13.0'
  spec.add_dependency 'friendly_id', '>= 5.2.0'
  spec.add_dependency 'gravatar_image_tag'
  spec.add_dependency 'rails', '>= 6.0.0'

  spec.add_development_dependency "pg"
  spec.add_development_dependency "standard"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "mysql2"
  spec.add_development_dependency "sqlite3"
end

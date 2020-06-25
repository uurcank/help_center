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
  spec.description   = %q{A wiki gem for creating documentation & help centers in your Rails app}
  spec.homepage      = "https://github.com/uurcank/help_center"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency 'font-awesome-sass', '~> 5.13.0'
  spec.add_dependency 'friendly_id', '>= 5.2.0'
  spec.add_dependency 'gravatar_image_tag'
  spec.add_dependency 'rails', '>= 6.0.0'
  spec.add_dependency 'will_paginate', '>= 3.1.0'
end

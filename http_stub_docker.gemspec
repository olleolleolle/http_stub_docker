# -*- encoding: utf-8 -*-
$LOAD_PATH.push ::File.expand_path("../lib", __FILE__)

Gem::Specification.new do |spec|
  spec.name              = "http_stub_docker"
  spec.version           = "0.0.7"
  spec.platform          = Gem::Platform::RUBY
  spec.authors           = %w{ dueckes }
  spec.summary           = "Docker tools for http_stub"
  spec.description       = "Tools for building and distributing http_stub Docker containers"
  spec.email             = "matthew.ueckerman@myob.com"
  spec.homepage          = "http://github.com/MYOB-Technology/http_stub_docker"
  spec.rubyforge_project = "http_stub_docker"
  spec.license           = "MIT"

  spec.files = %w{ bin lib resource }.map { |dir| Dir.glob("./#{dir}/**/{*,.*}") }.flatten

  spec.require_path = "lib"

  spec.required_ruby_version = ">= 2.0"

  spec.add_runtime_dependency "rake", ">= 10.4"

  spec.add_dependency "http_stub", "~> 0.25"

  spec.add_development_dependency "rubocop",     "~> 0.43"
  spec.add_development_dependency "wait_until",  "~> 0.3"
  spec.add_development_dependency "travis-lint", "~> 2.0"
end

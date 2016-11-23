require 'bundler'
Bundler.require(:development)

require_relative '../lib/http_stub_docker'

require_relative '../example/configurer'

require_relative 'support/http_stub_docker/rake/arguments_fixture'
require_relative 'support/http_stub_docker/rake/task_generator_fixture'
require_relative 'support/http_stub_docker/rake/with_docker_resources'

RSpec.configure do |config|
  config.include Rake::DSL
end

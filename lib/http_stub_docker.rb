require 'http_stub/rake/task_generators'

module HttpStubDocker

  BASE_DIR = File.expand_path("../..", __FILE__).freeze

end

require_relative 'http_stub_docker/rake/server_daemon_tasks'
require_relative 'http_stub_docker/rake/resource_tasks'
require_relative 'http_stub_docker/rake/container_tasks'
require_relative 'http_stub_docker/rake/pipeline_tasks'
require_relative 'http_stub_docker/rake/task_generator'

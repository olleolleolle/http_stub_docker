require 'bundler'
require 'bundler/gem_tasks'
Bundler.require(:default, :development)

require_relative 'lib/http_stub_docker'
require_relative 'example/stub_configurator'

directory "pkg"

desc "Remove generated artefacts"
task :clobber  do
  %w{ pkg tmp }.each { |dir| rm_rf dir }
  puts "Clobbered"
end

HttpStubDocker::Rake::TaskGenerator.new(stub_configurator: HttpStubDocker::Example::StubConfigurator,
                                        stub_name:         :http_stub_docker_example_stub,
                                        stub_dir:          File.expand_path("..", __FILE__),
                                        port:              5005,
                                        publish_tags:      [ ENV["BUILD_NUMBER"] ])

begin
  require 'rubocop/rake_task'
  require 'rspec/core/rake_task'

  desc "Source code metrics analysis"
  RuboCop::RakeTask.new(:metrics) { |task| task.fail_on_error = true }

  namespace :provision do

    desc "Provisions AWS resources needed for specifications"
    task :aws do
      sh "spec/ops/terraform.sh plan"
      sh "spec/ops/terraform.sh apply"
    end

  end

  namespace :spec do

    desc "Exercises specifications relying on local infrastructure"
    ::RSpec::Core::RakeTask.new(:local) do |task|
      task.rspec_opts = "--tag ~aws"
    end

    desc "Exercises specifications relying on aws infrastructure"
    ::RSpec::Core::RakeTask.new(:aws) do |task|
      task.rspec_opts = "--tag aws"
    end

  end

  task :validate do
    print " Travis CI Validation ".center(80, "*") + "\n"
    result = `travis-lint #{::File.expand_path('../.travis.yml', __FILE__)}`
    puts result
    print "*" * 80 + "\n"
    raise "Travis CI validation failed" unless $?.success?
  end

  task pre_commit: %w{ clobber metrics spec:local validate }

  task default: :pre_commit

  task commit: %w{ clobber metrics spec:local provision:aws spec:aws }
rescue LoadError
  # development Gems are not available in container
end

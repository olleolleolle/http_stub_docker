require 'bundler'
require 'bundler/gem_tasks'
Bundler.require(:default, :development)

require_relative 'lib/http_stub_docker'
require_relative 'example/configurer'

directory "pkg"

desc "Remove generated artefacts"
task :clobber  do
  %w{ pkg tmp }.each { |dir| rm_rf dir }
  puts "Clobbered"
end

HttpStubDocker::Rake::TaskGenerator.new(configurer: HttpStubDocker::Examples::Configurer,
                                        stub_name:  :example_stub,
                                        stub_dir:   File.expand_path("..", __FILE__),
                                        port:       5005)

begin
  require 'rubocop/rake_task'
  require 'rspec/core/rake_task'

  desc "Source code metrics analysis"
  RuboCop::RakeTask.new(:metrics) { |task| task.fail_on_error = true }

  desc "Exercises unit tests"
  ::RSpec::Core::RakeTask.new(:unit)

  desc "Exercises acceptance tests"
  task acceptance: %w{ docker:setup docker:commit docker:clobber }

  task :validate do
    print " Travis CI Validation ".center(80, "*") + "\n"
    result = `travis-lint #{::File.expand_path('../.travis.yml', __FILE__)}`
    puts result
    print "*" * 80 + "\n"
    raise "Travis CI validation failed" unless $?.success?
  end

  task :default => %w{ clobber metrics unit acceptance }

  task :pre_commit => %w{ default validate }
rescue LoadError
  # development Gems are not available in container
end

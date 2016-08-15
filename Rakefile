require 'bundler'
require 'bundler/gem_tasks'
Bundler.require(:default, :development)

require_relative 'lib/http_stub_docker'
require_relative 'example/configurer'

directory "pkg"

desc "Removed generated artefacts"
task :clobber  do
  %w{ pkg tmp }.each { |dir| rm_rf dir }
  puts "Clobbered"
end

begin
  require 'rubocop/rake_task'

  desc "Source code metrics analysis"
  RuboCop::RakeTask.new(:metrics) { |task| task.fail_on_error = true }
rescue LoadError
  # Server Daemon tasks are usable without development Gems
end

task :validate do
  print " Travis CI Validation ".center(80, "*") + "\n"
  result = `travis-lint #{::File.expand_path('../.travis.yml', __FILE__)}`
  puts result
  print "*" * 80+ "\n"
  raise "Travis CI validation failed" unless $?.success?
end

HttpStubDocker::Rake::TaskGenerator.new(configurer: HttpStubDocker::Examples::Configurer,
                                        stub_name:  :example_stub,
                                        stub_dir:   File.expand_path("..", __FILE__),
                                        port:       3000)

task :default => %w{ clobber metrics docker:setup docker:commit docker:clobber }

task :pre_commit => %w{ default validate }

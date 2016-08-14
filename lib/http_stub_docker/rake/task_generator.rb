module HttpStubDocker
  module Rake

    class TaskGenerator < ::Rake::TaskLib

      DOCKER_TASK_CLASSES = [
        HttpStubDocker::Rake::ResourceTasks,
        HttpStubDocker::Rake::ContainerTasks,
        HttpStubDocker::Rake::PipelineTasks
      ].freeze

      private_constant :DOCKER_TASK_CLASSES

      def initialize(args)
        resolved_args = args
        resolved_args[:external_base_uri] ||= "http://localhost:#{args[:port]}"
        HttpStubDocker::Rake::ServerDaemonTasks.new(resolved_args)
        namespace :docker do
          DOCKER_TASK_CLASSES.each { |task_class| task_class.new(resolved_args) }
        end
      end

    end

  end
end

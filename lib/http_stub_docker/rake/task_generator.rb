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
        arguments = HttpStubDocker::Rake::Arguments.new(args)
        HttpStubDocker::Rake::ServerDaemonTasks.new(arguments)
        namespace :docker do
          DOCKER_TASK_CLASSES.each { |task_class| task_class.new(arguments) }
        end
      end

    end

  end
end

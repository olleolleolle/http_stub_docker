module HttpStubDocker
  module Rake

    class PipelineTasks < ::Rake::TaskLib

      PUBLISH_SCRIPT = "#{HttpStubDocker::BASE_DIR}/bin/push_docker_image_to_ecr.sh".freeze

      private_constant :PUBLISH_SCRIPT

      def initialize(args)
        define_test_task(args)
        define_commit_task(args)
        define_publish_task(args)
      end

      private

      def define_test_task(args)
        desc "Verifies container is running"
        task(:test) do
          Bundler.require(:test)
          Wait.until!(description: "#{args.stub_name} is running", timeout_in_seconds: 10) do
            raise "#{args.stub_name} is not running" unless server_running?(args)
          end
          puts "#{args.stub_name} is running"
        end
      end

      def define_commit_task(args)
        desc "Ensures container runs"
        task(commit: [ "#{args.task_prefix}docker:build", "#{args.task_prefix}docker:start" ]) do
          begin
            ::Rake::Task["#{args.task_prefix}docker:test"].invoke
          ensure
            ::Rake::Task["#{args.task_prefix}docker:stop"].invoke
          end
        end
      end

      def define_publish_task(args)
        desc "Publishes the container"
        task(publish: "#{args.task_prefix}docker:build") do
          begin
            sh "#{PUBLISH_SCRIPT} #{args.stub_name} #{args.publish_tags.join(" ")}"
          rescue RuntimeError
            raise "Error publishing container"
          end
        end
      end

      def server_running?(args)
        response = Net::HTTP.get_response(URI("#{args.external_base_uri}/http_stub/status"))
        response.body == "OK"
      end

    end

  end
end

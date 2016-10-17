module HttpStubDocker
  module Rake

    class PipelineTasks < ::Rake::TaskLib

      PUBLISH_SCRIPT = "#{HttpStubDocker::BASE_DIR}/bin/push_docker_image_to_ecr.sh".freeze

      VALID_STUB_RESPONSE_CODES = %w{ 200 302 }.freeze

      private_constant :PUBLISH_SCRIPT, :VALID_STUB_RESPONSE_CODES

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
            response = Net::HTTP.get_response(URI("#{args.external_base_uri}/http_stub"))
            raise "#{args.stub_name} is not running" unless VALID_STUB_RESPONSE_CODES.include?(response.code)
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
          system "#{PUBLISH_SCRIPT} #{args.stub_name} #{args.version}"
        end
      end

    end

  end
end

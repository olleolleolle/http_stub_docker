module HttpStubDocker
  module Rake

    class ContainerTasks < ::Rake::TaskLib

      def initialize(args)
        define_build_task(args)
        define_start_task(args)
        define_connect_task(args)
        define_stop_task(args)
      end

      private

      def define_build_task(args)
        desc "Builds the image"
        task(:build) do
          system "docker build -t #{args.stub_name} ."
        end
      end

      def define_start_task(args)
        desc "Starts a container"
        task(:start) do
          system "docker run -d " \
                 "-p #{args.port}:#{args.port} " \
                 "-e STUB_EXTERNAL_BASE_URI=#{args.external_base_uri} " \
                 "#{args.stub_name}"
        end
      end

      def define_connect_task(args)
        desc "Connects to a running container"
        task(:connect) do
          system "docker exec -it #{container_ids(args).first} /bin/sh"
        end
      end

      def define_stop_task(args)
        desc "Stops all containers"
        task(:stop) do
          container_ids(args).each { |container_id| system "docker rm -f #{container_id}" }
        end
      end

      def container_ids(args)
        `docker ps -a --filter ancestor=#{args.stub_name} --format "{{.ID}}"`.split
      end

    end

  end
end

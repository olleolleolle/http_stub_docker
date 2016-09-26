module HttpStubDocker
  module Rake

    class ServerDaemonTasks

      def initialize(args)
        HttpStub::Server::Daemon.log_dir = ::File.expand_path("#{args.stub_dir}/tmp/log", __FILE__)
        HttpStub::Server::Daemon.pid_dir = ::File.expand_path("#{args.stub_dir}/tmp/pids", __FILE__)

        configurer = args.configurer
        configurer.stub_server.host = "localhost"
        configurer.stub_server.port = args.port
        HttpStub::Rake::ServerDaemonTasks.new(name: :stub_server, configurer: configurer)
      end

    end

  end
end

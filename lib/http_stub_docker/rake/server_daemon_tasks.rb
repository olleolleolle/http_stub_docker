module HttpStubDocker
  module Rake

    class ServerDaemonTasks

      def initialize(args)
        HttpStub::Server::Daemon.log_dir = ::File.expand_path("#{args.stub_dir}/tmp/log", __FILE__)
        HttpStub::Server::Daemon.pid_dir = ::File.expand_path("#{args.stub_dir}/tmp/pids", __FILE__)

        stub_configurator = args.stub_configurator
        stub_configurator.stub_server.port = args.port
        HttpStub::Rake::ServerDaemonTasks.new(name: :stub_server, configurator: stub_configurator)
      end

    end

  end
end

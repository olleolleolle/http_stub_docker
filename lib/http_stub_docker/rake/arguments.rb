module HttpStubDocker
  module Rake

    class Arguments

      DEFAULT_PORT = 5000

      private_constant :DEFAULT_PORT

      attr_reader :configurer, :stub_name, :stub_dir, :port, :external_base_uri, :version, :task_prefix

      def initialize(args)
        @port = ENV["port"] || DEFAULT_PORT
        args.each { |name, value| self.instance_variable_set("@#{name}", value) }
        @external_base_uri ||= "http://localhost:#{@port}"
        @task_prefix = current_rake_namespace
      end

      private

      def current_rake_namespace
        ::Rake.application.current_scope.empty? ? "" : "#{::Rake.application.current_scope.to_a.reverse.join(":")}:"
      end

    end

  end
end

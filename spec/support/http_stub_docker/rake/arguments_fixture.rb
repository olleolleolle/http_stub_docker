module HttpStubDocker
  module Rake

    class ArgumentsFixture

      DEFAULT_ARGUMENTS = {
        configurer: HttpStubDocker::Example::Configurer,
        stub_name:  :http_stub_docker_spec_stub,
        stub_dir:   HttpStubDocker::BASE_DIR,
        port:       5006
      }.freeze

      private_constant :DEFAULT_ARGUMENTS

      def self.args_hash(args={})
        DEFAULT_ARGUMENTS.merge(args)
      end

    end

  end
end

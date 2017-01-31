module HttpStubDocker
  module Rake

    class TaskGeneratorFixture

      def self.generate(args={})
        resolved_args = {
          configurer:   HttpStubDocker::Example::Configurer,
          stub_name:    :http_stub_docker_example_stub,
          stub_dir:     File.expand_path("../../../../..", __FILE__),
          port:         5005,
          publish_tags: "1.0.0"
        }.merge(args)
        HttpStubDocker::Rake::TaskGenerator.new(
          HttpStubDocker::Rake::ArgumentsFixture.args_hash(resolved_args)
        )
      end

    end

  end
end
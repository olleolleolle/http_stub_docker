module HttpStubDocker
  module Rake

    class TaskGeneratorFixture

      def self.generate(args={})
        HttpStubDocker::Rake::TaskGenerator.new(HttpStubDocker::Rake::ArgumentsFixture.args_hash(args))
      end

    end

  end
end
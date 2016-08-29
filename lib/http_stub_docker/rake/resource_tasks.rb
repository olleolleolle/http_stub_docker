module HttpStubDocker
  module Rake

    class ResourceTasks < ::Rake::TaskLib

      def initialize(args)
        define_clobber_task(args)
        define_setup_task(args)
      end

      private

      def define_clobber_task(args)
        desc "Removes created Dockerfile and other resources"
        task(:clobber) do
          resources = Dir.entries("#{HttpStubDocker::BASE_DIR}/resource").find_all { |file| !File.directory?(file) }
          rm resources.map { |resource| "#{args[:stub_dir]}/#{resource}" }, force: true
        end
      end

      def define_setup_task(args)
        desc "Creates Dockerfile and other resources in stub directory"
        task(:setup) do
          cp_r "#{HttpStubDocker::BASE_DIR}/resource/.", args[:stub_dir]
        end
      end

    end

  end
end

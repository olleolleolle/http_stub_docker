module HttpStubDocker
  module Rake

    class ResourceTasks < ::Rake::TaskLib

      RESOURCE_DIR             = "#{HttpStubDocker::BASE_DIR}/resource".freeze
      DOCKERFILE_TEMPLATE_PATH = "#{RESOURCE_DIR}/Dockerfile.erb".freeze

      private_constant :RESOURCE_DIR, :DOCKERFILE_TEMPLATE_PATH

      def initialize(args)
        define_clobber_task(args)
        define_setup_task(args)
      end

      private

      def define_clobber_task(args)
        desc "Removes created Dockerfile and other resources"
        task(:clobber) do
          resources = Dir.entries("#{HttpStubDocker::BASE_DIR}/resource")
                         .reject { |file| File.directory?(file) }
                         .map    { |file| file.end_with?(".erb") ? file[0..-5] : file }
          rm resources.map { |resource| "#{args.stub_dir}/#{resource}" }, force: true
        end
      end

      def define_setup_task(args)
        desc "Creates Dockerfile and other resources in stub directory"
        task(:setup) do
          copy_template_files(args)
          copy_non_template_files(args)
        end
      end

      def copy_non_template_files(args)
        files = Dir.entries(RESOURCE_DIR)
                   .reject { |file| File.directory?(file) || file.end_with?(".erb") }
                   .map { |file| "#{RESOURCE_DIR}/#{file}" }
        files.map { |file| "#{args.stub_dir}/#{File.basename(file)}" }
             .select { |destination_file| File.exist?(destination_file) }
             .each { |destination_file| rm_f(destination_file) }
        cp_r files, args.stub_dir
      end

      def copy_template_files(args)
        dockerfile_erb     = ERB.new(File.read(DOCKERFILE_TEMPLATE_PATH))
        dockerfile_content = dockerfile_erb.result(args.instance_eval { binding })
        File.write("#{args.stub_dir}/Dockerfile", dockerfile_content)
      end

    end

  end
end

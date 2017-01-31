describe "The docker:publish task" do
  include_context "with Docker resources"

  let(:task) { Rake::Task["#{task_prefix}docker:publish"] }

  subject { task.invoke }

  context "when the tasks were generated with invalid publish settings" do

    let(:task_namespace) { :docker_publish_invalid_args }
    let(:task_args)      { { version: "" } }

    it "raises an error indicating that the container could not be published" do
      expect { subject }.to raise_error("Error publishing container")
    end

  end

  context "when the tasks were generated with valid publish settings", aws: true do

    let(:task_namespace) { :docker_publish_valid_args }
    let(:stub_name)      { :publish_example_stub }
    let(:version)        { ENV["BUILD_NUMBER"] }
    let(:task_args)      { { stub_name: stub_name, version: version } }

    let(:image_verification_script) { File.expand_path("../../bin/verify_docker_image_in_ecr.sh", __FILE__) }

    it "uploads an image to AWS ECR with the specified tag" do
      subject

      unless system "#{image_verification_script} #{stub_name} #{version}"
        raise "Published image not found"
      end
    end

  end

end

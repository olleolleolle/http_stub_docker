describe "The docker:publish task" do
  include_context "with Docker resources"

  let(:task) { Rake::Task["#{task_namespace}:docker:publish"] }

  subject { task.invoke }

  context "when the tasks were generated with invalid publish settings" do

    before(:context) do
      namespace(:invalid_publish_settings) do
        HttpStubDocker::Rake::TaskGeneratorFixture.generate
      end
    end

    let(:task_namespace) { :invalid_publish_settings }

    it "raises an error indicating that the container could not be published" do
      expect { subject }.to raise_error("Error publishing container")
    end

  end

end

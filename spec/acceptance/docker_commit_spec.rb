describe "The docker:commit task" do
  include_context "with Docker resources"

  let(:task) { Rake::Task["#{task_prefix}docker:commit"] }

  subject { task.invoke }

  context "when valid commit arguments are provided" do

    let(:task_namespace) { :docker_commit_valid_arguments }

    it "executes without error" do
      expect { subject }.to_not raise_error
    end

  end

end

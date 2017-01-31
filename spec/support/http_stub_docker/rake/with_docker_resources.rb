shared_context "with Docker resources" do

  let(:task_prefix) { task_namespace ? "#{task_namespace}:" : "" }
  let(:task_args)   { {} }

  before(:example) do
    namespace(task_namespace) do
      HttpStubDocker::Rake::TaskGeneratorFixture.generate(task_args)
    end
  end

  before(:example) { Rake::Task["#{task_prefix}docker:setup"].invoke }

  after(:example) { Rake::Task["#{task_prefix}docker:clobber"].invoke }

end

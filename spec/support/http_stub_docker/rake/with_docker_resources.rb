shared_context "with Docker resources" do

  let(:task_namespace) { nil }
  let(:task_prefix)    { task_namespace ? "#{task_namespace}:" : "" }

  before(:example) { Rake::Task["#{task_prefix}docker:setup"].invoke }

  after(:example) { Rake::Task["#{task_prefix}docker:clobber"].invoke }

end

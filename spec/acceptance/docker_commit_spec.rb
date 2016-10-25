describe "The docker:commit task" do

  context "when valid commit arguments are provided" do

    subject { system "rake docker:commit" }

    before(:example) { system "rake docker:setup" }

    after(:example) { system "rake docker:clobber" }

    it "executes without error" do
      expect(subject).to be(true)
    end

  end

end

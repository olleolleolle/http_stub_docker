describe HttpStubDocker::Rake::Arguments do

  let(:arguments_hash) { {} }

  let(:arguments) { described_class.new(arguments_hash) }

  describe "#port" do

    subject { arguments.port }

    context "when an environment variable is established" do

      before(:example) do
        @original_port = ENV["port"]
        ENV["port"]    = "5001"
      end

      after(:example) { ENV["port"] = @original_port }

      it "has the value of the environment variable" do
        expect(subject).to eql("5001")
      end

    end

    context "when the hash contains a port" do

      let(:arguments_hash) { { port: 5002 } }

      it "has the hash value" do
        expect(subject).to eql(5002)
      end

    end

    context "when no value is provided" do

      it "defaults to 5000" do
        expect(subject).to eql(5000)
      end

    end

  end
end

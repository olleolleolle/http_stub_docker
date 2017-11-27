module HttpStubDocker
  module Example

    class StubConfigurator
      include HttpStub::Configurator

      stub_server.add_scenario_with_one_stub!("A Scenario") do
        match_requests(uri: "/some_endpoint", method: :get)
        respond_with(status: 200, body: "Some body")
      end

    end

  end
end

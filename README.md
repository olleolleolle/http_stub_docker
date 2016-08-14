### http_stub_docker
Rake tasks for building, verifying and distributing [http_stub](https://github.com/MYOB-Technology/http_stub
[Docker](https://www.docker.com/) containers.

## How do I use it?
1. In your Gemfile: `gem 'http_stub_docker'`
2. In your Rakefile:
```ruby
require 'http_stub_docker/rake/task_generator'

HttpStubDocker::Rake::TaskGenerator.new(
  stub_name: :my_stub, stub_dir: __dir__, port: 8001
)
HttpStubDocker::Rake::TaskGenerator.new(
  stub_name: :my_stub, stub_dir: __dir__, port: 8001, external_base_uri: "http://some_host_name:8001"
) # Should the stub require a custom uri
```
3. Use the generated Rake tasks:
```
# rake -T

```
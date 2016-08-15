http_stub_docker
================

Rake tasks for building, verifying and distributing [http_stub](https://github.com/MYOB-Technology/http_stub
[Docker](https://www.docker.com/) containers.

Status
------

[![Build Status](https://travis-ci.org/MYOB-Technology/http_stub_docker.png)](https://travis-ci.org/MYOB-Technology/http_stub_docker)
[![Gem Version](https://badge.fury.io/rb/http_stub_docker.png)](http://badge.fury.io/rb/http_stub_docker)
[![Code Climate](https://codeclimate.com/github/MYOB-Technology/http_stub_docker/badges/gpa.svg)](https://codeclimate.com/github/MYOB-Technology/http_stub_docker)
[![Dependency Status](https://gemnasium.com/MYOB-Technology/http_stub_docker.png)](https://gemnasium.com/MYOB-Technology/http_stub_docker)

How do I use it?
----------------

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
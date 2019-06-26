http_stub_docker
================

Rake tasks for building, verifying and distributing [Docker](https://www.docker.com) containers hosting
[http_stub](https://github.com/MYOB-Technology/http_stub) servers.

Status
------

[![Build Status](https://travis-ci.org/MYOB-Technology/http_stub_docker.png)](https://travis-ci.org/MYOB-Technology/http_stub_docker)
[![Gem Version](https://badge.fury.io/rb/http_stub_docker.png)](http://badge.fury.io/rb/http_stub_docker)
[![Code Climate](https://codeclimate.com/github/MYOB-Technology/http_stub_docker/badges/gpa.svg)](https://codeclimate.com/github/MYOB-Technology/http_stub_docker)
[![Dependency Status](https://gemnasium.com/MYOB-Technology/http_stub_docker.png)](https://gemnasium.com/MYOB-Technology/http_stub_docker)

What Does It Do?
----------------

Provides `rake` tasks that:

* Create standard Docker files for [http_stub](https://github.com/MYOB-Technology/http_stub) servers
* Build, start, stop and connect to `http_stub` server Docker containers
* Verify that the container is running correctly
* Deploy the container to [AWS ECR](https://aws.amazon.com/ecr)

Requirements
------------

* Ruby >= 2.3
* Docker >= 17.06

How Do I Use It?
----------------

1. In your `Gemfile`: `gem 'http_stub_docker'`
2. In your `Rakefile`:

    ```ruby
    require 'http_stub_docker/rake/task_generator'
    
    HttpStubDocker::Rake::TaskGenerator.new(
      stub_configurator: My::Configurator,
      stub_name:         :my_stub,
      stub_dir:          File.expand_path("..", __FILE__),
      port:              5005,                             # Optional: overrides default of 5000, also configurable via PORT environment variable
      external_base_uri: "http://some-host:5005",          # Optional: overrides default of http://localhost:<port>
      publish_tags:      %w{ 1.0.0 }                       # Optional: only required for ECR deployment
    )
    ```
3. Use the generated Rake tasks:

    ```
    $ rake -T
    rake docker:build                  # Builds the image
    rake docker:clobber                # Removes created Dockerfile and other resources
    rake docker:commit                 # Ensures container runs
    rake docker:connect                # Connects to a running container
    rake docker:publish                # Publishes the container
    rake docker:setup                  # Creates Dockerfile and other resources in stub directory
    rake docker:start                  # Starts a container
    rake docker:stop                   # Stops all containers
    rake docker:test                   # Verifies container is running
    rake stub_server:restart           # Restart an potentially running stub_server
    rake stub_server:start             # Start a stub_server as a background process
    rake stub_server:start:foreground  # Start stub stub_server in the foreground
    rake stub_server:status            # Display the status of a stub_server process
    rake stub_server:stop              # Stop a running stub_server
    ```
4. To publish to [AWS ECR](https://aws.amazon.com/ecr):

    * Ensure the [AWS CLI](https://aws.amazon.com/cli/) is installed
    * Establish the following environment variables: `AWS_ACCESS_KEY_ID`, `AWS_SECRET_ACCESS_KEY`, `AWS_ID` and `AWS_REGION`
    * Ensure the AWS user has write access to ECR
    * Run `docker:publish` task

Recommendations
---------------

In your `Rakefile`:

```ruby
task default: %w{ docker:setup docker:commit docker:publish }
```

Acknowledgements
----------------

Thanks to [Ryan Davis](https://github.com/Rypac) for his contributions on publishing to ECR.

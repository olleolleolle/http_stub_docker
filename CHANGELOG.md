** 0.2.0.beta1 **

Breaking:
* Renames `configurer` argument to `stub_configurator`

Misc:
* Bumps `http_stub` to `0.28.0.beta1`
* Bumps container Ruby to 2.4.2

** 0.1.3 **

Misc:
* Excluded Rubocop config from Docker image

** 0.1.2 **

New:
* Gem user has more flexibility on `http_stub` version in use

** 0.1.1 **

Breaking:
* `HttpStubDocker::Rake::TaskGenerator` `version` option replaced by `publish_tags`

** 0.1.0 **

Breaking:
* Supported Ruby versions now >= 2.2.2 (as per `http_stub`)

Misc:
* Bumps container Ruby to 2.4.0
* Integration tests verify `docker:publish` successfully publishes containers

Fix:
* All tasks issuing shell commands fail when underlying command fails

** 0.0.12 **

Fix:
* `docker:publish` task fails (has non-zero exit code) when publication fails

** 0.0.11 **

Fix:
* Considers stub server started when the servers status is initialized

** 0.0.10 **

Fix:
* Considers stub server started when status code is 200 or 302

** 0.0.9 **

New:
* `port` is configurable via environment variable

** 0.0.8 **

Fix:
* .dockerignore ignores Dockerfile

** 0.0.7 **

New:
* `port` configures both the container and host port

Misc:
* Tolerates tasks being defined within namespace (`http_stub` support pending)

** 0.0.6 **

New:
* `port` is optional, defaults to 5000

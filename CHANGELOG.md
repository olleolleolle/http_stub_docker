** 0.1.1 **

Breaking:
* `HttpStubDocker::Rake::TaskGenerator` `version` option replaced by `publish_tags`

** 0.1.0 **

Breaking:
* Supported Ruby versions now >= 2.2.2 (as per `http_stub`)

Misc:
* Bumped container Ruby to 2.4.0
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

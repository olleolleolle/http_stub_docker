FROM ruby:2.3.1-alpine

# Update Bundler
RUN gem install bundler

# Cache dependencies
COPY ["Gemfile", "Gemfile.lock", "*.gemspec", "/tmp/cache/"]
WORKDIR /tmp/cache
RUN bundle install --without test && rm -rf /tmp/cache

# Copy code
COPY . /root/app/
WORKDIR /root/app

# Registers bundle in working directory
RUN bundle install

# Expose server port
EXPOSE 80

# Start server & tail logs in order to sustain foreground process
CMD trap exit TERM; bundle exec rake stub_server:start && tail -f tmp/log/server_console.log

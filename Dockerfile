# Ref: https://hackernoon.com/dockerizing-an-existing-rails-postgresql-app-with-docker-compose-a30a7e1b3f40
FROM ruby:2.6.5
MAINTAINER upender@gleecus.com
# Install apt based dependencies required to run Rails as
# well as RubyGems. As the Ruby image itself is based on a
# Debian image, we use apt-get to install those.
RUN apt-get update -qq && apt-get install -y build-essential libpq-dev nodejs
# Configure the main working directory. This is the base
# directory used in any further RUN, COPY, and ENTRYPOINT
# commands.
RUN mkdir /worldzon-catalog-service
WORKDIR /worldzon-catalog-service
# Copy the Gemfile as well as the Gemfile.lock and install
# the RubyGems. This is a separate step so the dependencies
# will be cached unless changes to one of those two files
# are made.
COPY Gemfile /worldzon-catalog-service/Gemfile
COPY Gemfile.lock /worldzon-catalog-service/Gemfile.lock
# RUN bundle install
RUN gem install bundler && bundle install --jobs 20 --retry 5
# Copy the main application.
COPY . /worldzon-catalog-service
# Expose port 3000 to the Docker host, so we can access it
# from the outside.
EXPOSE 3000

# The main command to run when the container starts. Also
# tell the Rails dev server to bind to all interfaces by
# default#.
# CMD ["bundle", "exec", "rails", "server", "-b", "0.0.0.0"]
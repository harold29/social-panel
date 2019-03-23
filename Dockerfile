FROM ruby:2.6.2
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /social-panel
WORKDIR /social-panel
COPY Gemfile /social-panel/Gemfile
COPY Gemfile.lock /social-panel/Gemfile.lock
RUN bundle install
COPY . /social-panel

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000

# Start the main process.
CMD ["rails", "server", "-b", "0.0.0.0"]

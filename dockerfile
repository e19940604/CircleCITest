FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client
RUN mkdir /rorapp
WORKDIR /rorapp
COPY Gemfile /rorapp/Gemfile
COPY Gemfile.lock /rorapp/Gemfile.lock
RUN bundle install
COPY . /rorapp

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000


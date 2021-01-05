FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y nodejs postgresql-client cron rsyslog

WORKDIR /myapp
COPY Gemfile /myapp/Gemfile
COPY Gemfile.lock /myapp/Gemfile.lock
RUN bundle install
COPY . /myapp


# Give execution rights on the cron job
RUN chmod 0744 /etc/crontab
RUN chmod 0744 /myapp

# Create cron jobs from whenever gem
RUN whenever --update-crontab

# List active cron jobs ready 
RUN crontab -l

# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000


# Start the main process.
 CMD ["rails", "server", "-b", "0.0.0.0"]


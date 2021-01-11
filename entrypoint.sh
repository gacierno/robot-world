#!/bin/bash
set -e

# Remove a potentially pre-existing server.pid for Rails.
rm -f /myapp/tmp/pids/server.pid

# Verify Data Base
rake db:create
rake db:migrate

# Generate content to models table if its empty
rake dataload:models

# Create cron jobs from whenever gem
whenever --update-crontab

# List active cron jobs ready 
crontab -l

# Start/Launch Cron Jobs
service cron start

# Then exec the container's main process (what's set as CMD in the Dockerfile).
exec "$@"


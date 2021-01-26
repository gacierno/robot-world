# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever

ENV.each { |k, v| env(k, v) }

set :output, '/myapp/cron.log' # log location
set :environment, 'development'

every 1.minutes do
	rake "robot:builder:start"
end

every 1.days do
	rake "robot:builder:cleanup"
end

every 1.minutes do
	rake "robot:guard:inspect_cars"
end

every 30.minutes do
	rake "robot:guard:move_cars"
end

every 30.minutes do
	rake "robot:car_delivery"
end

every 1.minutes do
	rake "robot:buyer:buy_cars"
end

every 1.hours do
	rake "robot:buyer:ask_for_a_car_change"
end

every 1.days do
	rake "robot:execs"
end

every 1.days do
	rake "robot:repairer"
end
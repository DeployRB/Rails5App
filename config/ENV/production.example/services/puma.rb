# THIS FILE SHOULDN'T BE USED ON A PRODUCTION SERVER
# SEE `config/ENV/production/services` directory

# https://github.com/puma/puma/blob/master/examples/config.rb
# https://www.digitalocean.com/community/tutorials/how-to-deploy-a-rails-app-with-puma-and-nginx-on-ubuntu-14-04

app_dir = File.expand_path("../../../../", __FILE__)

sockets_dir = "#{ app_dir }/tmp/sockets"
pids_dir    = "#{ app_dir }/tmp/pids"
logs_dir    = "#{ app_dir }/log"

# Specifies the number of `workers` to boot in clustered mode.
# Workers are forked webserver processes. If using threads and workers together
# the concurrency of the application would be max `threads` * `workers`.
# Workers do not work on JRuby or Windows (both of which do not support
# processes).
#
workers 2

# Puma can serve each request in a thread from an internal thread pool.
# The `threads` method setting takes two numbers a minimum and maximum.
# Any libraries that use thread pools should be configured to match
# the maximum value specified for Puma. Default is set to 5 threads for minimum
# and maximum, this matches the default thread size of Active Record.
#
threads 5, 10

daemonize true
environment "production"

bind "unix://#{ sockets_dir }/puma.sock"

pidfile    "#{ pids_dir }/puma.pid"
state_path "#{ pids_dir }/puma.state"

stdout_redirect \
  "#{ logs_dir }/puma.stdout.log",
  "#{ logs_dir }/puma.stderr.log",
  true

activate_control_app

# The code in the `on_worker_boot` will be called if you are using
# clustered mode by specifying a number of `workers`. After each worker
# process is booted this block will be run, if you are using `preload_app!`
# option you will want to use this block to reconnect to any threads
# or connections that may have been created at application boot, Ruby
# cannot share connections between processes.
#
on_worker_boot do
  require "active_record"
  ActiveRecord::Base.connection.disconnect! rescue ActiveRecord::ConnectionNotEstablished
  ActiveRecord::Base.establish_connection(YAML.load_file("#{app_dir}/config/database.yml")["production"])
end

# Use the `preload_app!` method when specifying a `workers` number.
# This directive tells Puma to first boot the application and load code
# before forking the application. This takes advantage of Copy On Write
# process behavior so workers use less memory. If you use this option
# you need to make sure to reconnect any threads in the `on_worker_boot`
# block.
#
# preload_app!

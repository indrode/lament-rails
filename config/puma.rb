environment 'production'
daemonize true

pidfile '/home/akira/lament-rails/shared/tmp/pids/puma.pid'
state_path '/home/akira/lament-rails/shared/tmp/pids/puma.state'

threads 2, 4
bind 'unix:///home/akira/lament-rails/shared/tmp/sockets/puma.sock'

on_worker_boot do
  ActiveRecord::Base.establish_connection
end

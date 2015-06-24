require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
require 'mina/rbenv'
require 'mina/crono'

set :domain, 'tetsuo'
set :deploy_to, '/home/akira/lament-rails'
set :repository, 'git@github.com:indrode/lament-rails.git'
set :branch, 'master'

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'log', 'tmp/sockets', 'tmp/pids']

task :environment do
  invoke :'rbenv:load'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task setup: :environment do
  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/log")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/log")

  queue! %(mkdir -p "#{deploy_to}/#{shared_path}/config")
  queue! %(chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/config")

  queue! %(touch "#{deploy_to}/#{shared_path}/config/database.yml")
  queue %(echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'.")
end

desc 'Deploys the current version to the server.'
task deploy: :environment do
  deploy do

    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      # This kills the current Puma process, then restarts it
      queue! "kill $(cat #{deploy_to}/#{shared_path}/tmp/pids/puma.pid)"
      queue! "cd #{deploy_to}/#{current_path} && bundle exec puma -C config/puma.rb"
    end

    invoke :'crono:restart'
  end
end

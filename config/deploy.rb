# config valid only for current version of Capistrano
lock "~> 3.10"

set :branch, ENV.fetch('REVISION', 'master')

set :application, "document_generator"
set :repo_url, "git@git.servis.justice.cz:justice_core/document_generator.git"

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, "/srv/#{fetch(:application)}"

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: "log/capistrano.log", color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
append :linked_files, "config/database.yml", "config/secrets.yml", "config/unicorn.rb", "config/config.yml"

# Default value for linked_dirs is []
# append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets", "public/system"
append :linked_dirs, "log", "tmp/pids", "tmp/cache", "tmp/sockets"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for local_user is ENV['USER']
# set :local_user, -> { `git config user.name`.chomp }

# Default value for keep_releases is 5
# set :keep_releases, 5

# after "deploy:symlink:linked_dirs", "deploy:symlink_config_files"

set :bundle_env_variables, {
  'http_proxy' => 'http://proxy.justice.cz:3128/',
  'https_proxy' => 'http://proxy.justice.cz:3128/'
}

set :sidekiq_options, "-q default -q mailers"

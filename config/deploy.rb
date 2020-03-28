RAILS_ROOT = File.expand_path("../../", __FILE__)

require "figaro"
@figaro = Figaro
@figaro.application = @figaro::Application.new(environment: :development, path: File.join(RAILS_ROOT, "config", "application.yml"))
@figaro.load

task :tail_logs do
  on roles (:app) do
    tail "#{shared_path}/log/*.log"
  end
end

set :application, @figaro.env.app_name
set :repo_url, @figaro.env.git_respository

ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory
set :deploy_to, "~/servers/" + @figaro.env.app_name + "/production"
set :shared_path, "#{deploy_to}/shared"

#set :rbenv_ruby, File.read('.ruby-version').strip
set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
set :rbenv_map_bins, %w{rake gem bundle ruby rails pumactl puma}
set :rbenv_roles, :all # default value

set :assets_roles, [:app]
set :git_enable_submodules, false
set :use_sudo, false

#set :passenger_roles, :app
#set :passenger_restart_runner, :sequence
#set :passenger_restart_wait, 5
#set :passenger_restart_limit, 2
#set :passenger_restart_with_sudo, false
#set :passenger_environment_variables, {}
#set :passenger_restart_command, "passenger-config restart-app"
#set :passenger_restart_options, -> { "#{deploy_to} --ignore-app-not-running" }

#set :log_level, :debug
set :pty, true

set :linked_files, %w{config/application.yml}
set :linked_dirs, %w{.bundle log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :keep_releases, 20

set :user, "deploy"
set :ssh_options, {
  user: fetch(:user),
  forward_agent: true,
}

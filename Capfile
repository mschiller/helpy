# Load DSL and Setup Up Stages
require "capistrano/setup"

# Includes default deployment tasks
require "capistrano/deploy"

require "capistrano/scm/git"
install_plugin Capistrano::SCM::Git

# Includes tasks from other gems included in your Gemfile
require "capistrano/rails"
require "capistrano/bundler"
require "capistrano/rbenv"
require "capistrano/passenger"
require "capistrano/yarn"
require "whenever/capistrano"

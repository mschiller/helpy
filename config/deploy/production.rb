server @figaro.env.production_domain, roles: %w{web app db}

set :rails_env, :production
set :branch, :master

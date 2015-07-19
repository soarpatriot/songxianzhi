set :stage, :local
set :server_name, "test.yuxian.me"

set :branch, "dev"

set :log_level, :debug
set :deploy_to, "/data/www/city"

set :thin_config, "#{shared_path}/config/thin.yml"
set :thin_pid, "#{shared_path}/tmp/pids/thin.0.pid"


#set :password, ask('Server password', nil)
#server fetch(:server_name), user: 'soar', port: 22, password: fetch(:password), roles: %w{web app db}

server fetch(:server_name), user: "soar", roles: %w{web app db}

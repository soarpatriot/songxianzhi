# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'songxianzhi'
set :repo_url, 'git@github.com:soarpatriot/songxianzhi.git'

set :rails_env, 'production'

set :rvm_type, :user
set :rvm_ruby_version, '2.1.3'

set :scm, :git

set :format, :pretty
set :log_level, :debug
set :pty, true

set :linked_files, %w{config/database.yml  config/secrets.yml}

set :linked_dirs, %w{bin log tmp public/system public/assets public/uploads}

set :keep_releases, 5

namespace :deploy do

  task :start do
    invoke :"rvm:hook"
    on roles :app do
      within current_path do
        unless test("[ -f #{fetch(:thin_pid)} ]")
          info ">>>>>> starting thin"
          execute :bundle, "exec thin start -C #{fetch(:thin_config)}"
        else
          error ">>>>>> thin already started"
        end
      end
    end
  end

  task :stop do

    on roles :app do
      within current_path do
        if test("[ -f #{fetch(:thin_pid)} ]")
          info ">>>>>> stopping thin"
          execute :bundle, "exec thin stop -C #{fetch(:thin_config)}"
        else
          error ">>>>>> can not stop. there is no started thin"
        end
      end
    end
  end

  task :restart do
    invoke :"deploy:stop"
    invoke :"deploy:start"
  end

  after :finishing, 'deploy:cleanup'
end

after "deploy:check", "nginx:update_config"
after "deploy:check", "thin:update_config"
before "deploy:cleanup_assets", "rvm:hook"
before "deploy:compile_assets", "rvm:hook"
before "bundler:install", "rvm:hook"
after "deploy:publishing", "deploy:restart"

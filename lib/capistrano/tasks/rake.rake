desc "Invoke rake task"
task :rake do
  invoke "rvm:hook"
  on roles :app do
    within current_path do
      execute :bundle, "exec rake #{ENV['task']} RAILS_ENV=#{fetch(:rails_env)}"
    end
  end
end

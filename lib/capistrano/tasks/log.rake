namespace :log do
  task :rails do
    on roles :app do
      execute "tail -f #{shared_path}/log/production.log"
    end
  end

  task :n100 do
    on roles :app do
      execute "tail -n1000 #{shared_path}/log/production.log"
    end
  end
end

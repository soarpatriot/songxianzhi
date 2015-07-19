namespace :nginx do

  task :update_config do
    on roles :web do
      dest = "#{shared_path}/config/nginx.conf"
      upload! from_template("nginx.conf.erb"), dest
      info "Uploaded to '#{fetch(:server_name)}@#{dest}'"
    end
  end

end

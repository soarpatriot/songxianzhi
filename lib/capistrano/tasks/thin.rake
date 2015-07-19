namespace :thin do

  desc "upload unicorn config"
  task :update_config do
    on roles :web do
      dest = "#{shared_path}/config/thin.yml"
      upload! from_template("thin.conf.erb"), dest
      info "Uploaded to '#{fetch(:server_name)}@#{dest}'"
    end
  end

end

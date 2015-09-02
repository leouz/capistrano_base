namespace :log_tail do

  desc "tail rails logs"
  task :rails do
    on roles(:app) do
      execute "tail -f #{shared_path}/log/#{fetch(:rails_env)}.log"
    end
  end

  desc "tail sendmail logs"
  task :sendmail do
    on roles(:app) do
      execute "tail -f /var/log/mail.log"
    end
  end

  desc "tail nginx_access logs"
  task :nginx_access do
    on roles(:app) do
      execute "tail -f /var/log/nginx/access.log"
    end
  end

  desc "tail nginx_error logs"
  task :nginx_error do
    on roles(:app) do
      execute "tail -f /var/log/nginx/error.log"
    end
  end

end

namespace :deploy do
  %w[database application].each do |file|
    desc "create #{file}.yml file"
    task "create_#{file}_file" do
      on roles(:app), in: :sequence, wait: 5 do
        execute "mkdir -p #{shared_path}/config"
        upload! "#{fetch(:local_shared_files_dir)}/#{file}.yml", "#{shared_path}/config/#{file}.yml"
      end
    end
  end

  desc "Restarting mod_rails with restart.txt"
  task :restart_mod_rails do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute "touch #{current_path}/tmp/restart.txt"
      end
    end
  end

  desc "Disallow robots unless deploying to production."
  task :disallow_robots do
    on roles(:app), in: :sequence, wait: 5 do
      unless fetch(:capistrano_stage).to_sym == :production
        within release_path do
          execute :echo, "\"User-agent: *\nDisallow: /\n\" > public/robots.txt"
        end
      end
    end
  end

  desc "Add env.txt file unless deploying to production."
  task :add_env_file do
    on roles(:app), in: :sequence, wait: 5 do
      unless fetch(:capistrano_stage).to_sym == :production
        within release_path do
          execute :echo, "\" rails_env: #{fetch(:rails_env)} \n capistrano_stage: #{fetch(:capistrano_stage)} \n release: #{fetch(:release_name)} \n datetime: #{Time.now.to_s} \" > public/env.txt"
        end
      end
    end
  end

  desc "Restart Nginx"
  task :restart_nginx do
    on roles(:app), in: :sequence, wait: 5 do
      execute :sudo, "service nginx restart"
    end
  end
end

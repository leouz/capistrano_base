namespace :db do
  desc "reload the database with seed data"
  task :seed do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :rake, "db:seed RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end

  desc "reload the database with populate data"
  task :populate do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :rake, "db:populate RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end

  desc "reset database"
  task :reset do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :rake, "db:drop RAILS_ENV=#{fetch(:rails_env)}"
        execute :rake, "db:create RAILS_ENV=#{fetch(:rails_env)}"
        execute :rake, "db:migrate RAILS_ENV=#{fetch(:rails_env)}"      
      end
    end
  end

  desc "migrate database"
  task :migrate do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do        
        execute :rake, "db:migrate RAILS_ENV=#{fetch(:rails_env)}"      
      end
    end
  end

  desc "create database"
  task :create do
    on roles(:app), in: :sequence, wait: 5 do
      within release_path do
        execute :rake, "db:create RAILS_ENV=#{fetch(:rails_env)}"
      end
    end
  end
end

set :application, "postprodukce"
set :repository, "git@github.com:ondrejbartas/postprodukce.git"
set :scm, "git"
set :deploy_via, :copy

role :web, "server3.railshosting.cz"
role :app, "server3.railshosting.cz"
role :db,  "server3.railshosting.cz", :primary => true

set :shared_configs, [ 'database.yml' ]

set :deploy_to, "/home/postprodukce/app/"
set :user, "postprodukce"

set :use_sudo, false

task :after_update_code, :roles => [:app, :db] do
  run "ln -nfs #{shared_path}/config/database.yml #{release_path}/config/database.yml"
end


namespace :deploy do
  task :start, :roles => :app do
  end
end

namespace :deploy do
  desc "Restart Application"
  task :restart, :roles => :app do
    run "touch #{current_path}/tmp/restart.txt"
  end
end

 desc "Copy configuration files to shared"
 task :copy_configs_to_shared, :roles => :app do
   put(File.read('config/database.yml'), "#{shared_path}/config/database.yml", :mode => 0644)
 end
 
 desc "Symlink configuration files"
 task :symlink_configuration_files, :roles => :app do
   run "mkdir -p #{shared_path}/config"
   shared_configs.each do |name|
     run "ln -nsf #{deploy_to}/#{shared_dir}/config/#{name} #{current_path}/config/#{name}"
 end

 after 'deploy:symlink', 'symlink_configuration_files'


 end
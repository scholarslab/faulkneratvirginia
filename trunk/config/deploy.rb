set :application, "faulkner"
#set :repository, 'https://subversion.lib.virginia.edu/repos/faulkner/trunk/'
set :repository, 'http://faulkneratvirginia.googlecode.com/svn/trunk/'

set :deploy_to, "/usr/local/projects/#{application}"
set :deploy_via, :remote_cache
set :user, 'sds-deployer'
set :runner, user
set :run_method, :run

set :scm, :subversion
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`

# The ENV environment variable defaults to "staging"
# To set this when executing a command, append "ENV=production"
# to the command string
set :env, ENV['ENV'].to_s.empty? ? 'staging' : ENV['ENV'].to_s

# define the server environments (staging/production etc.)
case env
when 'production'
  set :rails_env, 'quandu_production'
  role :app, "sds3.itc.virginia.edu" 
  role :app, "sds5.itc.virginia.edu", :no_release => true
  role :web, "sds3.itc.virginia.edu", "sds5.itc.virginia.edu", :no_release => true
  # execute the migrate tasks from sds1, even though the server is sds2
  role :db,  "sds3.itc.virginia.edu", :primary => true, :no_release=>true
  
when 'staging'
  set :rails_env, 'quandu_staging'
  role :app, "sds6.itc.virginia.edu"
  role :web, "sds6.itc.virginia.edu"
  # execute the migrate tasks from sds1, even though the server is sds2
  role :db,  "sds6.itc.virginia.edu", :primary => true, :no_release=>true
else
  raise 'Invalid stage (should be "staging" or "production")'
end

namespace :deploy do
  
  [:restart].each do |default_task|
    task default_task do
      # nothing
    end
  end
  
  desc 'Runs a subversion update on the texts but does not fully redeploy the data'
  task :update_xml, :roles=>:app, :except => {:no_release => true} do
    run "cd #{current_path}/cocoon/data && svn up"
  end
  
  desc 'Updates the css and javascript elements'
  task :update_assets, :roles => :app, :except => {:no_release => true} do
    run "cd #{current_path}/cocoon/css && svn up"
    run "cd #{current_path}/cocoon/javascript && svn up"
  end
  
  desc 'Set the symlink for the solr instance'
  task :index_symlink, :roles=>:app, :except => { :no_release => true } do
		run "cd #{current_path}/solr-home/data && ln -snf #{shared_path}/index index"
	end
	
	desc 'Reset the images folder in the cocoon directory to the static mount'
	task :image_symlink, :roles=>:app, :except => {:no_release => true} do
	  run "mv #{current_path}/cocoon/images #{current_path}/cocoon/images_bak"
	  run "ln -snf /usr/local/projects/faulkner/static/ #{current_path}/cocoon/images"
  end
end

namespace :solr do
  
  desc 'Runs the indexer/generate_index.sh script'
  task :index, :roles=>:app, :except=>{:no_release=>true} do
    run "cd #{current_path}/indexer && ./generate_index.sh"
  end
  
  desc 'Set the correct permissions on the solr data directory'
  task :set_perms, :roles=>:app, :except=>{:no_release=>true} do
    run %(cd #{current_path}/solr-home && chmod -R g+w ./data)
  end
  
end

after 'deploy', 'deploy:index_symlink', 'deploy:image_symlink', 'deploy:cleanup'
after 'deploy:cold', 'solr:set_perms', 'deploy:index_symlink', 'deploy:image_symlink', 'solr:index'

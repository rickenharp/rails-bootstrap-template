run "rm public/index.html"
generate(:controller, "welcome", "index")
route "root :to => 'welcome#index'"
rake("db:migrate")
 
git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"

# rspec

gem_group :development, :test do
  gem "rspec-rails"
end
run "bundle install"
generate('rspec:install')
git :add => "."
git :commit => "-a -m 'Add rspec'"

# cucumber

gem_group :test do
  gem 'cucumber-rails', :require => false
  gem 'database_cleaner'
end
run "bundle install"
generate('cucumber:install')
git :add => "."
git :commit => "-a -m 'Add cucumber'"


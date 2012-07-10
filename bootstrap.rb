gem "haml-rails"
run "rm public/index.html"
generate(:controller, "welcome", "index")
route "root :to => 'welcome#index'"
rake("db:migrate")
 
git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"

# pry

gem_group :development do
  gem "pry-rails"
end
run "bundle install"
git :add => "."
git :commit => "-a -m 'Use pry instead of irb'"

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

# compass & bootstrap

gem_group :assets do
  gem "compass-rails"
  gem "compass_twitter_bootstrap"
end

run "bundle install"
run "mv app/assets/stylesheets/application.css app/assets/stylesheets/application.scss"

File.open('app/assets/stylesheets/base.scss','w') do |f|
  f.puts <<-EOF
@import "compass";
@import "compass_twitter_bootstrap";

body {
  padding-bottom: 40px;
  padding-top: 60px;
}
  EOF
end

run "rm app/views/layouts/application.html.erb"
File.open('app/views/layouts/application.html.haml', 'w') do |f|
  f.puts <<-EOF
!!!
%html
  %head
    %title Application Title
    = stylesheet_link_tag    "application", :media => "all"
    = javascript_include_tag "application"
    = csrf_meta_tags
  %body
    = render 'layouts/nav'
    %div.container
      %div.content
        = yield
  EOF
end

File.open('app/views/layouts/_nav.html.haml', 'w') do |f|
  f.puts <<-EOF
%div{ :class => "navbar navbar-fixed-top"}
  %div{ :class => "navbar-inner"}
    %div{ :class => "container"}
      %a{ :class =>"brand"}
        Demo 
      %ul{ :class => "nav"}
        %li{ :class => "active"}
          = link_to 'Home', "#"
        %li
          = link_to 'Link', '#'
        %li
          = link_to 'Another LInk', '#'
      %ul{ :class => "nav pull-right"}
        %li
          = link_to 'Right Link', '#'
  EOF
end

git :add => "."
git :commit => "-a -m 'Add compass and bootstrap'"

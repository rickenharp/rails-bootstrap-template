run "rm public/index.html"
generate(:controller, "welcome", "index")
route "root :to => 'welcome#index'"
rake("db:migrate")
 
git :init
git :add => "."
git :commit => "-a -m 'Initial commit'"

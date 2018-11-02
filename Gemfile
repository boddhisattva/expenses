source "https://rubygems.org"

ruby "2.4.2"

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.2.8'

# Use postgres as the database for Active Record
gem "pg"

# Use SCSS for stylesheets
gem "sass-rails", "~> 5.0"

# Use Bootstrap
gem "bootstrap-sass", "~> 3.3.5.1"

# Use Uglifier as compressor for JavaScript assets
gem "uglifier", ">= 1.3.0"
# Use CoffeeScript for .coffee assets and views
gem "coffee-rails", "~> 4.1.0"
# See https://github.com/sstephenson/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem "turbolinks"
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem "jbuilder", "~> 2.0"
# bundle exec rake doc:rails generates the API under doc/api.
gem "sdoc", "~> 0.4.0", group: :doc

# Use ActiveModel has_secure_password
gem "bcrypt", "~> 3.1.7"

# Use Unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem "web-console", "~> 2.0"
end

group :development, :test do
  # Gems useful for debugging purposes
  gem "pry-rails"
  gem "awesome_print"
  gem "better_errors"
  gem "binding_of_caller"

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem "spring"
  gem "rspec-rails"
  gem "factory_girl_rails", "4.2.0"
  gem 'rubocop', require: false
  gem 'flamegraph'
  gem 'rack-mini-profiler'
  gem 'stackprof'
  gem 'fast_stack'
end

group :test do
  gem "poltergeist"
  gem "capybara", "2.5.0"
  gem "database_cleaner"
  gem "codeclimate-test-reporter", require: nil
  gem 'simplecov', :require => false, :group => :test
  gem "rspec_junit_formatter"
end

# To turn off Rails asset pipeline log.
gem "quiet_assets", group: :development

group :production do
  gem "rails_12factor", "0.0.2"
  gem "puma"
end

source "https://rails-assets.org" do
  gem "rails-assets-jquery", "2.1.4"
  gem "rails-assets-jquery-ujs", "1.1.0"
  gem "rails-assets-DataTables"
end

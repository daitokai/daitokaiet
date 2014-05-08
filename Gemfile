source 'https://rubygems.org'
ruby '2.0.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '4.0.5'

# Use sqlite3 as the database for Active Record
gem 'pg'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 4.0.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .js.coffee assets and views
gem 'coffee-rails', '~> 4.0.0'

# See https://github.com/sstephenson/execjs#readme for more supported runtimes
gem 'therubyracer', platforms: :ruby


# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.0'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

# Use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

gem "capybara", group: [:development, :test]
gem "devise"
gem "haml", ">= 3.0.0"
gem "haml-rails"
gem "jquery-rails"
gem "omniauth"
gem 'omniauth-twitter'

gem 'bootstrap-sass', '~> 3.0.3.0'
gem 'simple_form', git: 'git://github.com/zlx/simple_form', branch: 'feature/integration_bootstrap3'
gem 'heroku_san', git: 'git://github.com/jphenow/heroku_san', branch: 'bug/wrong-ruby-version-loaded'

gem 'twitter', '~> 5.0'
gem 'newrelic_rpm'
gem 'bugsnag'
gem 'ransack'

group :production, :staging do
  gem 'unicorn'
  gem 'rails_12factor'
end

gem 'pry-rails', group: [:development, :test]
gem 'coveralls', require: false

group :test do
  gem 'launchy'
  gem 'poltergeist'
  gem 'database_cleaner'
end

gem 'squeel'

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:mri_19, :mri_20, :rbx]
  gem 'guard-rspec'
  gem 'guard-pow'
  gem 'guard-spring'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
end

group :development, :test do
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'spring'
end

gem 'wisper'
gem 'doorkeeper'
gem 'jquery_mobile_rails'

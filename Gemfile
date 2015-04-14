source 'https://rubygems.org'
ruby '2.2.2'

gem 'rails', '4.2.1'
gem 'pg'
gem 'sass-rails', '~> 5.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.1.0'
gem 'therubyracer', platforms: :ruby
gem 'jbuilder', '~> 2.0'
gem 'devise'
gem 'haml', '>= 3.0.0'
gem 'haml-rails'
gem 'jquery-rails'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'bootstrap-sass'
gem 'simple_form'
gem 'twitter', '~> 5.0'
gem 'newrelic_rpm'
gem 'bugsnag'
gem 'wisper'
gem 'doorkeeper'
gem 'jquery_mobile_rails'
gem 'coveralls', require: false

gem 'ransack', github: 'activerecord-hackery/ransack'

group :test do
  gem 'launchy'
  gem 'poltergeist'
  gem 'database_cleaner'
end

group :development do
  gem 'better_errors'
  gem 'binding_of_caller', platforms: [:mri_19, :mri_20, :rbx]
  gem 'guard-rspec'
  gem 'guard-pow'
  gem 'html2haml'
  gem 'quiet_assets'
  gem 'rb-fchange', require: false
  gem 'rb-fsevent', require: false
  gem 'rb-inotify', require: false
  gem 'heroku_san', git: 'git://github.com/jphenow/heroku_san', branch: 'bug/wrong-ruby-version-loaded'
  gem 'web-console', '~> 2.0'
end

group :development, :test do
  gem 'pry-rails'
  gem 'capybara'
  gem 'factory_girl_rails'
  gem 'rspec-rails'
  gem 'spring'
  gem 'spring-commands-rspec'
end

group :production, :staging do
  gem 'unicorn'
  gem 'rails_12factor'
end

require 'capybara/rails'
require 'capybara/rspec'

require 'capybara/poltergeist'
include Capybara::DSL
Capybara.javascript_driver = :poltergeist

Capybara.register_driver :poltergeist do |app|
  options = {js_errors: false}
  Capybara::Poltergeist::Driver.new(app, options)
end

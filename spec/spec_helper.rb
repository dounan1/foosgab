ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'capybara/rails'
require 'capybara/rspec'
require 'capybara/poltergeist'
Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:default] = OmniAuth::AuthHash.new({
    provider: 'google_oauth2',
    uid: '77777'
  })
OmniAuth.config.mock_auth[:invalid] = :invalid_credentials

Capybara.javascript_driver = :poltergeist

RSpec.configure do |config|
  config.infer_base_class_for_anonymous_controllers = true
  config.order = "random"

  config.before :each do
    Mongoid.default_session.collections.each { |c| c.drop unless /^system/.match(c.name) }
  end
end
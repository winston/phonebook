require 'spec_helper'
require 'capybara/rails'
require 'site_prism'

require 'capybara/poltergeist'
Capybara.javascript_driver = :poltergeist

Dir[Rails.root.join("spec/features/pages/**/*.rb")].each {|f| require f}

module PageHelper
  def load(klass)
    page = klass.new
    page.load
    page
  end
end

RSpec.configure do |config|
  config.include PageHelper

  config.use_transactional_fixtures = false

  config.before(:suite) do
    DatabaseCleaner.strategy = :truncation
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

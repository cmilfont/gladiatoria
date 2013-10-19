ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

#require 'shoulda'
#require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}

Rspec.configure do |config|

  DatabaseCleaner.logger = Rails.logger

  config.before(:each) do
    DatabaseCleaner.strategy = :deletion
    DatabaseCleaner.start
    Rails.cache.clear
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end


end
require 'simplecov'
SimpleCov.start 'rails'

ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'

#require 'shoulda'
#require 'database_cleaner'

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }
Dir[Rails.root.join("spec/factories/**/*.rb")].each {|f| require f}

ActiveRecord::Migration.check_pending! if defined?(ActiveRecord::Migration)

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

  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = true

end

Rspec::Matchers.define :be_mapped_by do |expect|

  chain :with_boost do |boost|
    @boost = boost
  end

  match do |actual|
    @result = actual.class.index[ actual.class.name.tableize.to_sym ][:mappings][ actual.class.name.tableize.singularize.to_sym ][:properties][expect].present?
    @result = (@result && actual.class.index[ actual.class.name.tableize.to_sym ][:mappings][ actual.class.name.tableize.singularize.to_sym ][:properties][expect][:boost] == @boost) if @boost.present?
    @result
  end

  failure_message_for_should do |actual|
    @msg = "expected that #{actual.class} would be mapped by #{expected}"
    @msg = "expected that #{actual.class} would be mapped by #{expected} with boost #{@boost}" if @boost.present?
    @msg
  end

  failure_message_for_should_not do |actual|
    "expected that #{actual.class} would not be mapped by #{expected}"
  end

  description do
    "be mapped by #{expect}"
  end

end
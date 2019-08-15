require 'capybara'
require 'capybara/rspec'
require 'simplecov'
SimpleCov.start

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
  SimpleCov.formatter = Coveralls::SimpleCov::Formatter
end

require File.join(
          File.dirname(__FILE__),
          '..',
          'app/controllers/url_shortener.rb'
        )

Capybara.app = UrlShortener
RSpec.configure do |config|
  config.expect_with :rspec do |expectations|
    expectations.include_chain_clauses_in_custom_matcher_descriptions = true
  end

  config.mock_with :rspec do |mocks|
    mocks.verify_partial_doubles = true
  end

  config.shared_context_metadata_behavior = :apply_to_host_groups

  config.after(:suite) { FileUtils.rm_rf('url_pairs_test.json') }
end

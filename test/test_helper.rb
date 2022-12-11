ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "vcr"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  VCR.configure do |config|
    config.cassette_library_dir = File.expand_path("cassettes", __dir__)
    config.hook_into :webmock
  end
end

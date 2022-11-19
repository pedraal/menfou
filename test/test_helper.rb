ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...

  def login_as(user)
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:auth0] = nil
    OmniAuth.config.mock_auth[:auth0] = OmniAuth::AuthHash.new({
      extra: {
        raw_info: user.auth0_data
      }
    })

    Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:auth0]

    get auth_auth0_callback_path
  end
end

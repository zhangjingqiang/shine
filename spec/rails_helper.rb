# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require 'spec_helper'
require 'rspec/rails'
require "capybara/poltergeist"
require 'support/easy_screenshots'
require 'support/sign_up_and_login'

Capybara.javascript_driver = :poltergeist
Capybara.default_driver = :poltergeist
# Add additional requires below this line. Rails is not loaded until this point!

# Requires supporting ruby files with custom matchers and macros, etc, in
# spec/support/ and its subdirectories. Files matching `spec/**/*_spec.rb` are
# run as spec files by default. This means that files in spec/support that end
# in _spec.rb will both be required and run as specs, causing the specs to be
# run twice. It is recommended that you do not name files matching this glob to
# end with _spec.rb. You can configure this pattern with the --pattern
# option on the command line or in ~/.rspec, .rspec or `.rspec-local`.
#
# The following line is provided for convenience purposes. It has the downside
# of increasing the boot-up time by auto-requiring all files in the support
# directory. Alternatively, in the individual `*_spec.rb` files, manually
# require only the support files necessary.
#
# Dir[Rails.root.join('spec/support/**/*.rb')].each { |f| require f }

# Checks for pending migration and applies them before tests are run.
# If you are not using ActiveRecord, you can remove this line.
ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_path = "#{::Rails.root}/spec/fixtures"

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = false

  # RSpec Rails can automatically mix in different behaviours to your tests
  # based on their file location, for example enabling you to call `get` and
  # `post` in specs under `spec/controllers`.
  #
  # You can disable this behaviour by removing the line below, and instead
  # explicitly tag your specs with their type, e.g.:
  #
  #     RSpec.describe UsersController, :type => :controller do
  #       # ...
  #     end
  #
  # The different available types are documented in the features, such as in
  # https://relishapp.com/rspec/rspec-rails/docs
  config.infer_spec_type_from_file_location!

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")

  config.add_setting :screenshots_dir
  config.screenshots_dir = "#{::Rails.root}/spec/screenshots"
  config.include(EasyScreenshots, type: :feature)
  config.include(FactoryGirl::Syntax::Methods)
  config.include(Devise::TestHelpers, type: :controller)

  # Configure database_cleaner
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  config.before(:each, type: :feature) do
    DatabaseCleaner.strategy = :truncation
  end

  config.before(:each) do
    DatabaseCleaner.start
  end

  config.after(:each) do
    DatabaseCleaner.clean
  end
end

def create_states
  State.destroy_all
  State.create!(name: "Alabama"           , code: "AL")
  State.create!(name: "Alaska"            , code: "AK")
  State.create!(name: "Arizona"           , code: "AZ")
  State.create!(name: "Arkansas"          , code: "AR")
  State.create!(name: "California"        , code: "CA")
  State.create!(name: "Colorado"          , code: "CO")
  State.create!(name: "Connecticut"       , code: "CT")
  State.create!(name: "Delaware"          , code: "DE")
  State.create!(name: "Dist. of Columbia" , code: "DC")
  State.create!(name: "Florida"           , code: "FL")
  State.create!(name: "Georgia"           , code: "GA")
  State.create!(name: "Hawaii"            , code: "HI")
  State.create!(name: "Idaho"             , code: "ID")
  State.create!(name: "Illinois"          , code: "IL")
  State.create!(name: "Indiana"           , code: "IN")
  State.create!(name: "Iowa"              , code: "IA")
  State.create!(name: "Kansas"            , code: "KS")
  State.create!(name: "Kentucky"          , code: "KY")
  State.create!(name: "Louisiana"         , code: "LA")
  State.create!(name: "Maine"             , code: "ME")
  State.create!(name: "Maryland"          , code: "MD")
  State.create!(name: "Massachusetts"     , code: "MA")
  State.create!(name: "Michigan"          , code: "MI")
  State.create!(name: "Minnesota"         , code: "MN")
  State.create!(name: "Mississippi"       , code: "MS")
  State.create!(name: "Missouri"          , code: "MO")
  State.create!(name: "Montana"           , code: "MT")
  State.create!(name: "Nebraska"          , code: "NE")
  State.create!(name: "Nevada"            , code: "NV")
  State.create!(name: "New Hampshire"     , code: "NH")
  State.create!(name: "New Jersey"        , code: "NJ")
  State.create!(name: "New Mexico"        , code: "NM")
  State.create!(name: "New York"          , code: "NY")
  State.create!(name: "North Carolina"    , code: "NC")
  State.create!(name: "North Dakota"      , code: "ND")
  State.create!(name: "Ohio"              , code: "OH")
  State.create!(name: "Oklahoma"          , code: "OK")
  State.create!(name: "Oregon"            , code: "OR")
  State.create!(name: "Pennsylvania"      , code: "PA")
  State.create!(name: "Rhode Island"      , code: "RI")
  State.create!(name: "South Carolina"    , code: "SC")
  State.create!(name: "South Dakota"      , code: "SD")
  State.create!(name: "Tennessee"         , code: "TN")
  State.create!(name: "Texas"             , code: "TX")
  State.create!(name: "Utah"              , code: "UT")
  State.create!(name: "Vermont"           , code: "VT")
  State.create!(name: "Virginia"          , code: "VA")
  State.create!(name: "Washington"        , code: "WA")
  State.create!(name: "West Virginia"     , code: "WV")
  State.create!(name: "Wisconsin"         , code: "WI")
  State.create!(name: "Wyoming"           , code: "WY")
end
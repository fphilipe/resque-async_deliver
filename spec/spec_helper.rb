require 'support'

RSpec.configure do |config|
  config.raise_errors_for_deprecations!
  config.expect_with(:rspec) { |c| c.syntax = :expect }
end

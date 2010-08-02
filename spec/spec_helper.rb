require 'rubygems'
require 'bundler'
Bundler.setup
Bundler.require(:default, :test)

RAILS_ENV = 'test'

require 'spec/support/stubs'
require 'lib/simple_auth'
require 'spec/support/configuration'
require 'spec/support/mock_requests'

FakeWeb.allow_net_connect = false

RSpec.configure do |config|
  config.before(:each) do
    FakeWeb.clean_registry
  end
end

$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

RAILS_ENV = 'test'

require 'rubygems'
require 'bundler'
Bundler.setup

require 'action_controller'
require 'rest_client'

require 'simple-auth'
require 'spec'
require 'spec/autorun'

require 'fake_web'

Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |file| require File.expand_path(file) }

FakeWeb.allow_net_connect = false

Spec::Runner.configure do |config|
  
end

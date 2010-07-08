$LOAD_PATH.unshift(File.dirname(__FILE__))
$LOAD_PATH.unshift(File.join(File.dirname(__FILE__), '..', 'lib'))

RAILS_ENV = 'development'

require 'action_controller'
require 'rest_client'

require 'simple-auth'
require 'spec'
require 'spec/autorun'

require 'fake_web'

# Dir["#{File.dirname(__FILE__)}/factories/**/*.rb"].each { |factory| require File.expand_path(factory) }
Dir["#{File.dirname(__FILE__)}/support/**/*.rb"].each { |file| require File.expand_path(file) }

# FakeWeb.allow_net_connect = false
# FakeWeb.register_uri(:get, 'http://pt.optimis.local/user_session.json', :body => '{}', :status => [ '200', 'OK' ])

Spec::Runner.configure do |config|
  
end

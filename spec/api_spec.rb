require 'spec/spec_helper'

class ApplicationController < ActionController::Base
  include SimpleAuth
end

describe ApplicationController, '#api' do
  it 'should return the REST client' do
    subject.api.should be_instance_of RestClient::Resource
  end
end

describe ApplicationController, '#login' do
  before do
    FakeWeb.register_uri(:get,
      'http://pt.optimis.local/user_session.json',
      :body => '{ "session" : "test" }',
      :status => [ '200', 'OK' ],
      :content_type => 'application/json'
    )
    
    @controller = ApplicationController.new
    @controller.stub(:cookies).and_return({})
  end

  it 'should add the login method to the application controller' do
    @controller.should respond_to :login
  end

  it 'should set the current session' do
    @controller.session = {}
    @controller.login

    @controller.session[:current_session].should == "test"
  end
end

describe ApplicationController, '#login' do
  context 'The user is not logged into the Authenticator application' do
    it 'should redirect to the current practice path in optimis'
  end
end

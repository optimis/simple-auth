require 'spec/spec_helper'

describe SimpleAuth do
  subject { ApplicationController.new }

  before :all do
    class ApplicationController < ActionController::Base
      include SimpleAuth::Api
    end
  end

  describe '#api' do
    it 'should return the REST client' do
      subject.api.should be_instance_of RestClient::Resource
    end
  end

  describe '#login' do
    before do
      FakeWeb.register_uri(:get,
        'http://test.domain.local/user_session.json',
        :body => '{ "session" : "test" }',
        :status => [ '200', 'OK' ],
        :content_type => 'application/json'
      )
      
      subject.stub!(:cookies => {})
      subject.stub!(:redirect_to)
    end

    it 'should add the login method to the application controller' do
      subject.should respond_to :login
    end

    it 'should set the current session' do
      subject.stub!(:session => {})
      subject.login

      subject.session[:current_session].should == "test"
    end
  end

  describe '#login' do
    context 'The user is not logged into the authentication provider' do
      before do
        FakeWeb.register_uri(
          :get,
          'http://test.domain.local/user_session.json',
          :body => '<html></html>',
          :status => [ '200', 'OK' ],
          :content_type => 'text/html'
        )
        
        subject.stub!(:cookies => {})
      end

      it 'should redirect the user to the login page' do
        subject.should_receive :redirect_to
        subject.login
      end
    end

    context 'The user is logged into the authentication provider' do
      before do
        FakeWeb.register_uri(
          :get,
          'http://test.domain.local/user_session.json',
          :body => '{ "user", "", "session" : "test" }',
          :status => [ '200', 'OK' ],
          :content_type => 'application/json'
        )
        
        subject.stub!(:cookies => {})
        subject.stub!(:session => {})
      end

      it 'should not redirect the user to the login page' do
        subject.should_not_receive :redirect_to
        subject.login
      end
    end
  end

end

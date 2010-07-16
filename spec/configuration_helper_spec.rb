require 'spec/spec_helper'

class ApplicationController < ActionController::Base; end

describe ApplicationController do
  context '#api' do
    it 'should initialize the api path from the settings' do
      subject.api_host.should == 'http://test.domain.local'
    end
  end

  context '#path' do
    it 'should initialize the login path from the settings' do
      subject.login_path.should == 'login'
    end
  end

  context '#url' do
    it 'should initialize the login path from the settings' do
      subject.login_url.should == 'http://test.domain.local/login'
    end
  end
end

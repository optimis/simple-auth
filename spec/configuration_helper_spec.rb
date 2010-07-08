require 'spec/spec_helper'

class ApplicationController < ActionController::Base

end

describe ApplicationController, '#api' do
  before do
    @api_host = 'http://pt.optimis.local'
  end
  
  it 'should initialize the api path from the settings' do
    subject.api_host.should == @api_host
  end
end

describe ApplicationController, '#path' do
  before do
    @login_path = 'login'
  end

  it 'should initialize the login path from the settings' do
    subject.login_path.should == @login_path
  end
end

describe ApplicationController, '#url' do
  before do
    @login_url = 'http://pt.optimis.local/login'
  end

  it 'should initialize the login path from the settings' do
    subject.login_url.should == @login_url
  end
end

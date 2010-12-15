require 'spec/spec_helper'

class ApplicationController < ActionController::Base;
end

describe ApplicationController do
  context '#api' do
    after :each do
      SimpleAuth.configure do
        host do
          test 'test.domain.local'
        end
      end
    end
    it 'should initialize the api path from the settings' do
      subject.api_host.should == 'http://test.domain.local'
    end


    it 'should not add the protocol if the http protocol is already added' do
      SimpleAuth.configure do
        host do
          test 'http://test.domain.local'
        end
      end

      subject.api_host.should == 'http://test.domain.local'
    end

    it 'should not add the protocol if the https protocol is already added' do
      SimpleAuth.configure do
        host do
          test 'https://test.domain.local'
        end
      end

      subject.api_host.should == 'https://test.domain.local'
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

  context '#configure_from_yml' do
    before :each do
      @yaml = "host :\n  test : http://yaml.domain.local\npaths :\n  my_path : mypath"
    end

    after :each do
      SimpleAuth.configure do
        host do
          test 'https://test.domain.local'
        end
      end
    end

    it 'should load the host configuration from YAML' do
      SimpleAuth.configure_from_yml YAML.load(@yaml)

      subject.api_host.should == 'http://yaml.domain.local'
    end

    it 'should load paths from YAML' do
      SimpleAuth.configure_from_yml YAML.load(@yaml)

      subject.my_path_path.should == 'mypath'
    end
  end
end

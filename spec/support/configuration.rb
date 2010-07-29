SimpleAuth.configure do
  host do
    development 'test.domain.local'
    test 'test.domain.local'
    production 'test.domain.local'
  end

  paths do
    login 'login'
  end
end

ApplicationController.send(:include, SimpleAuth::Api)

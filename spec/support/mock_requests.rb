def mock_valid_login
  FakeWeb.register_uri(:get,
    'http://test.domain.local/user_session.json',
    :body => '{ "user" : "test", "session" : "test" }',
    :status => [ '200', 'OK' ],
    :content_type => 'application/json'
  )
end

def mock_invalid_login
  FakeWeb.register_uri(
    :get,
    'http://test.domain.local/user_session.json',
    :body => 'http://test.domain.local/login',
    :status => [ '302', 'Found' ],
    :content_type => 'text/html'
  )
end

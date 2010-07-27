module SimpleAuth
  module Api
    def self.api_host=(host)
      @api_host = host
    end

    def self.api_host
      @api_host
    end

    def api
      @api ||= RestClient::Resource.new(SimpleAuth::Api.api_host)
    end

    def login
      user_session = api['user_session.json'].get(:cookies => cookies)

      if user_session.headers[:content_type].include?('text/html')
        redirect_to login_url
        return
      else
        user_session_object = ActiveSupport::JSON.decode(user_session)
        session[:current_session] = user_session_object['session']
      end
    end

    def current_session
      session[:current_session]
    end
  end
end

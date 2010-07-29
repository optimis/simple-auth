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
      user_session = api['user_session.json'].get(:cookies => cookies) do |response, request, &block|
        if response.code == 200
          response.return!(request, &block)
          set_user_session(response)
        else
          # response.follow_redirection(request, &block)
          redirect_to response.headers[:location]
        end
      end
    end

    def current_session
      session[:current_session]
    end

    private

    def set_user_session(user_session)
      session[:current_session] = Yajl::Parser.new.parse(user_session)['session']
    end
  end
end

module SimpleAuth
  class HostConfiguration
    def self.test value
      method_missing('test', value)
    end

    def self.method_missing(name, value)
      if name.to_s == RAILS_ENV
        absolute_path = 'http://' + value
        path_getter = lambda { absolute_path }

        SimpleAuth::Api.api_host = absolute_path
        ActionController::Base.send(:define_method, 'api_host', &path_getter)
        ActionView::Base.send(:define_method, 'api_host', &path_getter)
      end
    end
  end

  class PathConfiguration
    def self.method_missing(name, value)
      ActionController::Base.send(:define_method, "#{name}_path", lambda { value })
      ActionController::Base.send(:define_method, "#{name}_url", lambda { api_host + '/' + value })
      ActionView::Base.send(:define_method, "#{name}_path", lambda { value })
      ActionView::Base.send(:define_method, "#{name}_url", lambda { api_host + '/' + value })
    end
  end

  def configure(&block)
    instance_eval(&block)
  end
  module_function :configure

  def host(&block)
    HostConfiguration.instance_eval(&block)
  end
  module_function :host

  def paths(&block)
    PathConfiguration.instance_eval(&block)
  end
  module_function :paths
end

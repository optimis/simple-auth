module SimpleAuth
  class HostConfiguration
    def method_missing(name, value)
      if name.to_s == RAILS_ENV
        ActionController::Base.send(:define_method, 'api_host', lambda { 'http://' + value })
      end
    end
  end

  class PathConfiguration
    def method_missing(name, value)
      ActionController::Base.send(:define_method, "#{name}_path", lambda { value })
      ActionController::Base.send(:define_method, "#{name}_url", lambda { api_host + '/' + value })
    end
  end

  def self.configure(&block)
    @host_configuration = HostConfiguration.new
    @path_configuration = PathConfiguration.new
    instance_eval(&block)
  end

  def host(&block)
    @host_configuration.instance_eval(&block)
  end
  module_function :host

  def paths(&block)
    @path_configuration.instance_eval(&block)
  end
  module_function :paths
end

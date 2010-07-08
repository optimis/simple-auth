module Kernel
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

  def config_api_host(&block)
    HostConfiguration.new.instance_eval(&block)
  end

  def config_api_path(&block)
    PathConfiguration.new.instance_eval(&block)
  end
end

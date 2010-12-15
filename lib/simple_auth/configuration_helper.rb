module SimpleAuth
  class HostConfiguration
    def self.test value
      method_missing('test', value)
    end

    def self.method_missing(name, value)
      if name.to_s == RAILS_ENV
        absolute_path = value =~ /https?:\/\// ? value : 'http://' + value
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

  def configure_from_yml(yml_hash)
    yml_hash['host'].keys.each do |env_name|
      host do
        send(env_name, yml_hash['host'][env_name])
      end

      yml_hash['paths'].keys.each do |path_name|
        paths do
          send(path_name, yml_hash['paths'][path_name])
        end
      end
    end
  end
  module_function :configure_from_yml
end

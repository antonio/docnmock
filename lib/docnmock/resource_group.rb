module Docnmock
  class ResourceGroup
    include Docnmock::Modules::Mock

    attr_reader :name, :resources, :api

    def initialize(api, name)
      raise "Invalid group name: #{name}" unless valid_name?(name)

      @api = api
      @name = name
      set_default_attributes
    end

    def description(new_description = nil)
      @description = new_description if new_description
      @description
    end

    def api_base_url
      api.base_url
    end

    def resource(method, path, &block)
      resource = find_resource(method, path) || create_resource(method, path)
      resource.tap {|r| r.instance_exec(&block) if block_given? }
    end

    private

    def valid_name?(name)
      name.is_a? String
    end

    def set_default_attributes
      @resources = []
      @description = ""
    end

    def find_resource(method, path)
      resources.find { |r| r.method == method && r.path == path }
    end

    def create_resource(method, path)
      Docnmock::Resource.new(method, path).tap {|r| resources << r}
    end
  end
end

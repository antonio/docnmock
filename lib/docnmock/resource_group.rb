module Docnmock
  class ResourceGroup

    attr_reader :name, :resources

    def initialize(name)
      raise "Invalid group name: #{name}" unless valid_name?(name)

      @name = name
      set_default_attributes
    end

    def description(new_description = nil)
      @description = new_description if new_description
      @description
    end

    def resource(method, path)
      resource = find_resource(method, path) || create_resource(method, path)
      resource
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
      resource = Docnmock::Resource.new(method, path)
      resources << resource
      resource
    end
  end
end

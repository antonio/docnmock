module Docnmock
  class Resource

    attr_reader :method, :path, :examples

    HTTP_METHODS = [:options, :get, :head, :post, :put, :delete, :trace,
                    :connect]

    def initialize(method, path)
      raise "Invalid HTTP method: #{method}" unless valid_method?(method)

      set_default_attributes
      @method = method
      @path   = path
    end

    def description(new_description = nil)
      @description = new_description if new_description
      @description
    end

    def example
    end

    def formats
    end

    def parameter
    end

    private

    def valid_method?(method)
      HTTP_METHODS.include? method
    end

    def set_default_attributes
      @description = ""
      @formats     = []
      @examples    = []
      @parameters  = []
    end
  end
end

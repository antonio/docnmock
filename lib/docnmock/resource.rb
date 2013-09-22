module Docnmock
  class Resource

    attr_reader :method, :path, :examples, :parameters, :examples

    HTTP_METHODS = [:options, :get, :head, :post, :put, :delete, :trace,
                    :connect]

    def initialize(method, path)
      check_arguments!(method, path)

      set_default_attributes
      @method = method
      @path   = path
    end

    def description(new_description = nil)
      @description = new_description if new_description
      @description
    end

    def example(params)
      Docnmock::Resource::Example.new(params[:path], params[:response])
                                 .tap {|e| examples << e}
    end

    def formats(response_formats = nil)
      @formats = Array(response_formats) if response_formats
      @formats
    end

    def parameter(attributes)
      Docnmock::Parameter.new(attributes).tap {|p| parameters << p}
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

    def check_arguments!(method, path)
      raise "Invalid HTTP method: #{method}" unless valid_method?(method)
      raise "Missing path" unless path
    end
  end
end

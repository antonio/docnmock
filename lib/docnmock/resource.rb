module Docnmock
  class Resource

    attr_reader :method, :path, :examples, :parameters, :examples

    HTTP_METHODS = [:options, :get, :head, :post, :put, :delete, :trace,
                    :connect]

    class Example < Struct.new(:path, :response)
      def initialize(path, response)
        super
        check_attributes!
      end

      def check_attributes!
        self.each_pair do |attr_name, attr_value|
          raise "Missing attribute: #{attr_name}" unless attr_value
        end
      end
    end

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

    def example(params)
      Example.new(params[:path], params[:response]).tap {|e| examples << e}
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
  end
end

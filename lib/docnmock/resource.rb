module Docnmock
  class Resource
    include Docnmock::Modules::Mock

    attr_reader :method, :path, :examples, :parameters, :examples, :api

    HTTP_METHODS = [:options, :get, :head, :post, :put, :delete, :trace,
                    :connect]

    def initialize(api, method, path)
      check_arguments!(method, path)

      set_default_attributes
      @api    = api
      @method = method
      @path   = path
    end

    def description(new_description = nil)
      @description = new_description if new_description
      @description
    end

    def example(params)
      Docnmock::Resource::Example.new(params[:path], params[:response],
                                      params[:parameters] || {})
                                 .tap {|e| examples << e}
    end

    def response(fixture)
      File.read("responses/#{fixture}")
    end

    def formats(response_formats = nil)
      @formats = Array(response_formats) if response_formats
      @formats
    end

    def parameter(attributes)
      Docnmock::Parameter.new(attributes).tap {|p| parameters << p}
    end

    def api_base_url
      api.base_url
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

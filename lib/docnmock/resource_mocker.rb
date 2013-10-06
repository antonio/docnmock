require 'webmock'

module Docnmock

  class ResourceMocker < Struct.new(:resource)
    include WebMock::API

    def mock
      resource.examples.each do |example|
        mock_example(resource.api_base_url, example)
      end
    end

    private

    def mock_example(base_url, example)
      self.send("mock_#{resource.method}", base_url, example)
    end

    def mock_get(base_url, example)
      stub_request(:get, "#{base_url}#{example.path}").to_return({body: example.response})
    end

    def mock_post(base_url, example)
      stub_request(:post, "#{base_url}#{example.path}")
                  .with(body: example.query_parameters)
                  .to_return({body: example.response})
    end

  end

end

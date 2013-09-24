require 'webmock'

module Docnmock

  class Mocker < Struct.new(:resource)
    include WebMock::API

    def mock
      resource.examples.each do |example|
        mock_example example
      end
    end

    private

    def mock_example(example)
      self.send("mock_#{resource.method}", example)
    end

    def mock_get(example)
      stub_request(:get, "www.example.com#{example.path}").to_return({body: example.response})
    end

    def mock_post(example)
      stub_request(:post, "www.example.com#{example.path}")
                  .with(body: example.query_parameters)
                  .to_return({body: example.response})
    end

  end

end

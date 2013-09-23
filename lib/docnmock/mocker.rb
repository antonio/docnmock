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
      stub_request(resource.method, "www.example.com#{example.path}").to_return({body: example.response})
    end

  end

end

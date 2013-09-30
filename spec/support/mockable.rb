shared_examples 'a mockable thing' do
  it { should respond_to(:mock) }
end

shared_context 'testing mocks' do
  before :each do
    WebMock.allow_net_connect!
  end

  after :each do
    WebMock.disable_net_connect!
  end

  let(:expected_response) { '{ "status":"success" }' }
  let(:path) { '/api/resource'}

  let(:get_resource) {
    Docnmock::Resource.new(:get, path).tap do |r|
      r.example path: path, response: expected_response
    end
  }

  let(:parameters) { {key: 'value'} }
  let(:query_parameters) do
    parameters.collect {|k,v| "#{k}=#{v}&" }.join.tap {|s| s.chop! if s.end_with?('&')}
  end
  let(:post_resource) {
    Docnmock::Resource.new(:post, path).tap do |r|
      r.example path: path, parameters: parameters,
        response: expected_response
    end
  }

  let(:resource_group) {
    Docnmock::ResourceGroup.new('Resource Group').tap do |rg|
      rg.resource(:get, path) do
        example path: '/api/resource', response: '{ "status":"success" }'
      end
    end
  }

end

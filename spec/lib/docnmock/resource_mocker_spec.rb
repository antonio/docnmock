require 'spec_helper'

describe Docnmock::ResourceMocker do

  describe 'initialization' do


    let(:api)      { double("api", base_url: 'http://www.example.com') }
    let(:resource) { Docnmock::Resource.new(api, :get, '/path') }

    it 'is initialized with a resource' do
      expect{Docnmock::ResourceMocker.new(resource)}.to_not raise_error
    end

  end

  describe 'mocking' do
    include_context 'testing mocks'

    context 'the resource is available via GET' do
      subject { Docnmock::ResourceMocker.new(get_resource) }

      it 'mocks the resource examples' do
        subject.mock
        response = Net::HTTP.get("www.example.com", path)
        expect(response).to eq(expected_response)
      end
    end

    context 'the resource is available via POST' do
      subject { Docnmock::ResourceMocker.new(post_resource) }

      it 'takes into account the parameters' do
        subject.mock
        response = Net::HTTP.new("www.example.com").post(path, query_parameters)
        expect(response.body).to eq(expected_response)
      end

      it 'does not mock the request if the parameters do not match the example' do
        subject.mock
        Net::HTTP.new("www.example.com").post(path, '')
        WebMock.should have_requested(:post, "www.example.com#{path}")
      end
    end
  end
end

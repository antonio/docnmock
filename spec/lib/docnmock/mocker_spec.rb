require 'spec_helper'

describe Docnmock::Mocker do

  describe 'initialization' do

    let(:resource) { Docnmock::Resource.new(:get, '/path') }

    it 'is initialized with a resource' do
      expect{Docnmock::Mocker.new(resource)}.to_not raise_error
    end

  end

  describe 'mocking' do

    let(:expected_response) { '{ "status":"success" }' }
    let(:path) { '/api/resource'}
    subject { Docnmock::Mocker.new(resource) }

    context 'the resource is available via GET' do
      let(:resource) {
        Docnmock::Resource.new(:get, path).tap do |r|
          r.example path: path, response: expected_response
        end
      }

      it 'mocks the resource examples' do
        subject.mock
        response = Net::HTTP.get("www.example.com", path)
        expect(response).to eq(expected_response)
      end
    end

    context 'the resource is available via POST' do
      let(:parameters) { {key: 'value'} }
      let(:query_parameters) do
        parameters.collect {|k,v| "#{k}=#{v}&" }.join.tap {|s| s.chop! if s.end_with?('&')}
      end
      let(:resource) {
        Docnmock::Resource.new(:post, path).tap do |r|
          r.example path: path, parameters: parameters,
                    response: expected_response
        end
      }

      before :each do
        WebMock.allow_net_connect!
      end

      after :each do
        WebMock.disable_net_connect!
      end

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

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
    let(:resource) {
      Docnmock::Resource.new(:get, path).tap do |r|
        r.example path: path, response: expected_response
      end
    }

    subject { Docnmock::Mocker.new(resource) }

    it 'mocks the resource examples' do
      subject.mock
      response = Net::HTTP.get("www.example.com", path)
      expect(response).to eq(expected_response)
    end

    it 'takes into account parameters in POST'
  end
end

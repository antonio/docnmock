require 'spec_helper'

describe Docnmock::ApiMocker do

  describe 'initialization' do

    let(:api) { double('api')}

    it 'is initialized with an api' do
      expect{Docnmock::ApiMocker.new(api)}.to_not raise_error
    end
  end

  describe 'mocking' do
    include_context 'testing mocks'

    subject { Docnmock::ApiMocker.new(api) }

    it { should respond_to(:mock) }

    it 'should mock the resources inside the group' do
      subject.mock
      response = Net::HTTP.get("www.example.com", path)
      expect(response).to eq(expected_response)
    end

  end
end

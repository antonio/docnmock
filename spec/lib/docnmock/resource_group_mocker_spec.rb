require 'spec_helper'

describe Docnmock::ResourceGroupMocker do

  describe 'initialization' do

    let(:resource_group) { double('resource_group')}

    it 'is initialized with a resource group' do
      expect{Docnmock::ResourceGroupMocker.new(resource_group)}.to_not raise_error
    end
  end

  describe 'mocking' do
    include_context 'testing mocks'

    subject { Docnmock::ResourceGroupMocker.new(resource_group) }

    it { should respond_to(:mock) }

    it 'should mock the resources inside the group' do
      subject.mock
      response = Net::HTTP.get("www.example.com", path)
      expect(response).to eq(expected_response)
    end

  end

end

require 'spec_helper'

describe Docnmock::Resource::Example do

  let(:path) { '/path' }
  let(:response) { '{ "response": "true" }' }
  let(:parameters) { {key: 'value'} }

  describe 'initialization' do
    it 'fails with no path' do
      expect{ Docnmock::Resource::Example.new(nil, response) }.to raise_error
    end

    it 'fails with no response' do
      expect{ Docnmock::Resource::Example.new(path, nil) }.to raise_error
    end

    it 'accepts parameters as an extra argument' do
      expect{ Docnmock::Resource::Example.new(path, response, parameters)}
            .to_not raise_error
    end
  end

  describe 'attributes' do
    subject { Docnmock::Resource::Example.new(path, response, parameters) }

    it { should respond_to(:path) }
    it { should respond_to(:response) }
    it { should respond_to(:parameters) }

    [:path, :response, :parameters].each do |attribute|
      it "returns the #{attribute}" do
        expect(subject.public_send(attribute.to_sym)).to eq(send(attribute))
      end
    end
  end
end

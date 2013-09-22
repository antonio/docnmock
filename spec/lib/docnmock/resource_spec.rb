require 'spec_helper'

describe Docnmock::Resource do

  subject { Docnmock::Resource.new(:get, '/path') }

  describe 'initialization' do
    it 'fails for invalid HTTP methods' do
      expect{Docnmock::Resource.new(:meh, '/path')}.to raise_error
    end
  end

  describe 'attributes' do
    it { should respond_to(:description) }
    it { should respond_to(:example) }
    it { should respond_to(:formats) }
    it { should respond_to(:method) }
    it { should respond_to(:parameter) }
    it { should respond_to(:path) }

    describe 'defaults' do
      it 'has a default description' do
        expect(subject.description).to_not be_nil
      end
      it 'has default formats' do
        expect(subject.formats).to_not be_nil
      end
      it 'has a default parameters' do
        expect(subject.parameters).to_not be_nil
      end
      it 'has a default examples' do
        expect(subject.examples).to_not be_nil
      end
    end

    describe '#parameter' do
      it 'creates a new parameter' do
        parameter = subject.parameter name: 'parameter', required: true
        expect(parameter).to be_an_instance_of Docnmock::Parameter
      end
    end

    describe '#example' do
      let(:example) { subject.example path: '/example',
                                      response: '{ "example": "true" }' }

      it 'creates a new example' do
        expect(example).to be_an_instance_of Docnmock::Resource::Example
      end

      it 'adds the example to the list' do
        expect(subject.examples).to include(example)
      end
    end
  end

end

require 'spec_helper'

describe Docnmock::Parameter do

  describe 'initialization' do
    it 'takes a hash of attributes' do
      expect{Docnmock::Parameter.new(name: 'name', required: false)}.to_not raise_error
    end

    context 'with invalid attributes' do
      it 'raises an error' do
        expect{Docnmock::Parameter.new(name: 'name', invalid: true)}.to raise_error
      end
    end
  end

  describe 'attributes' do
    subject { Docnmock::Parameter.new(name: 'name', type: 'type', required: false, description: 'Description') }

    it { should respond_to(:name) }
    it { should respond_to(:type) }
    it { should respond_to(:required) }
    it { should respond_to(:description) }

    it 'provides defaults' do
      parameter = Docnmock::Parameter.new(name: 'name')
      expect(parameter.description).to_not be_nil
    end

    it 'sets the attributes correctly' do
      expect(subject.name).to eq('name')
    end
  end

end

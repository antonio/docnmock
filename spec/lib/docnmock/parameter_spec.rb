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
    let(:name)        { 'name' }
    let(:type)        { 'type' }
    let(:required)    { false }
    let(:description) { 'Description' }

    subject { Docnmock::Parameter.new(name: name, type: type,
                                      required: required, description: description) }

    it { should respond_to(:name) }
    it { should respond_to(:type) }
    it { should respond_to(:required) }
    it { should respond_to(:description) }

    it 'provides defaults' do
      parameter = Docnmock::Parameter.new(name: 'name')
      expect(parameter.required).to be_false
    end

    Docnmock::Parameter::VALID_ATTRS.each do |attribute|

      it "sets the attribute #{attribute} correctly" do
        expect(subject.public_send(attribute)).to eq(send(attribute))
      end

    end
  end

end

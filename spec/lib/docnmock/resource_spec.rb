require 'spec_helper'

describe Docnmock::Resource do

  let(:path) { '/path' }

  subject { Docnmock::Resource.new(:get, path) }

  describe 'initialization' do
    it 'fails for invalid HTTP methods' do
      expect{Docnmock::Resource.new(:meh, path)}.to raise_error
    end
    it 'fails if a path is not specified' do
      expect{Docnmock::Resource.new(:get, nil)}.to raise_error
    end
    context 'with valid parameters' do
      it 'does not fail' do
        expect{Docnmock::Resource.new(:get, path)}.to_not raise_error
      end
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

      [:description, :formats, :examples, :parameters].each do |attribute|

        it "has a default #{attribute}" do
          expect(subject.public_send(attribute)).to_not be_nil
        end

      end
    end

    describe '#description' do
      let(:new_description) { 'A new description' }

      it 'updates the description' do
        subject.description new_description
        expect(subject.description).to eq(new_description)
      end

    end

    describe '#formats' do
      let(:new_formats) { [:json, :xml] }
      let(:single_format) { :json }

      context 'with an array of formats' do
        it 'updates the formats' do
          subject.formats new_formats
          expect(subject.formats).to eq(new_formats)
        end
      end

      context 'with a single format' do
        it 'automatically wraps it in an Array' do
          subject.formats single_format
          expect(subject.formats).to eq([single_format])
        end
      end

    end

    describe '#parameter' do
      let(:parameter) { subject.parameter name: 'parameter', required: true }

      it 'creates a new parameter' do
        expect(parameter).to be_an_instance_of Docnmock::Parameter
      end

      it 'adds the parameter to the list' do
        expect(subject.parameters).to include(parameter)
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

  it_behaves_like 'a mockable thing'

end

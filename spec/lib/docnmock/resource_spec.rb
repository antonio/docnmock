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
      it 'has default attributes' do
        expect(subject.description).to eq("")
      end
    end

  end

end

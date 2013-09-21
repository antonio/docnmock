require 'spec_helper'

describe Docnmock::ResourceGroup do

  describe 'constructor' do

    context 'with valid arguments' do
      it 'does not raise an error if initialized with a string' do
        expect{Docnmock::ResourceGroup.new('Group')}.to_not raise_error
      end
    end

    context 'with invalid arugments' do
      it 'does raise an error if initialized with a symbol' do
        expect{Docnmock::ResourceGroup.new(:users)}.to raise_error
      end
    end

  end

  describe 'attributes' do

    subject { Docnmock::ResourceGroup.new('Group') }

    it { should respond_to(:name) }
    it { should respond_to(:description) }
  end

end

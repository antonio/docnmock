require 'spec_helper'

describe Docnmock::ResourceGroup do

  subject { Docnmock::ResourceGroup.new('Group') }

  describe 'constructor' do

    context 'with valid arguments' do
      it 'does not raise an error' do
        expect{subject}.to_not raise_error
      end
    end

    context 'with invalid arguments' do
      it 'does raise an error' do
        expect{Docnmock::ResourceGroup.new(:users)}.to raise_error
      end
    end

  end

  describe 'attributes' do
    it { should respond_to(:name) }
    it { should respond_to(:description) }
  end

  describe 'resources' do
    it 'has a list of associated resources' do
      expect(subject.resources).to be_a_kind_of(Enumerable)
    end
  end

  describe '#resource' do
    it 'creates a new resource' do
      subject.resource :get, '/resource/:id'
      expect(subject.resources).to_not be_empty
    end

    it 'runs a block in the context of the resource' do
      resource = subject.resource :get, '/resource/:id' do
        description 'A resource'
        formats [:json, :xml]
      end
      expect(resource.description).to eq('A resource')
    end
  end

end

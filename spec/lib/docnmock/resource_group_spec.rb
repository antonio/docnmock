require 'spec_helper'

describe Docnmock::ResourceGroup do

  let(:api) { double("api", base_url: 'http://www.example.com') }

  subject { Docnmock::ResourceGroup.new(api, 'Group') }

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

    describe '#description' do
      let(:new_description) { 'A new description' }

      it 'updates the description' do
        subject.description new_description
        expect(subject.description).to eq(new_description)
      end

    end
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

    it 'yields control' do
      expect{ |probe| subject.resource :get, '/resource/:id', &probe}.to yield_control
    end
  end

  it_behaves_like 'a mockable thing'

end

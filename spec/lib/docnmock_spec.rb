require 'docnmock'

describe Docnmock do

  it { should respond_to(:resource_group) }
  it { should respond_to(:resource) }

  before(:each) do
    Docnmock.instance_variable_set(:@api, Docnmock::Api.new)
  end

  describe '.resource_group' do

    context 'with no arguments' do
      it 'raises an error' do
        expect{ Docnmock.resource_group }.to raise_error
      end
    end

    context 'with invalid arguments' do
      it 'raises an error' do
        expect{Docnmock.resource_group({})}.to raise_error
      end
    end

    context 'with valid arguments' do
      it 'creates a new group' do
        Docnmock.resource_group 'Users'
        expect(Docnmock.api.resource_groups).to_not be_empty
      end
    end

    context 'a group with that name does not exist' do
      it 'creates a new group' do
        expect(Docnmock.api.resource_groups).to be_empty
        Docnmock.resource_group 'Users'
        expect(Docnmock.api.resource_groups.first.name).to eq('Users')
      end
    end

    context 'a group with that name already exists' do
      it 'does not create a new group' do
        Docnmock.resource_group 'Users'
        Docnmock.resource_group 'Users'
        expect(Docnmock.api.resource_groups.size).to eq(1)
      end
    end

  end

end

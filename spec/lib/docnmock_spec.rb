require 'docnmock'

module MyModule
end

describe Docnmock do

  it 'hooks itself into another module' do
    Docnmock.hook_into(MyModule)
    expect(MyModule).to be_a_kind_of(Docnmock)
  end

  it { should respond_to(:resource_group) }

  before(:each) do
    Docnmock.instance_variable_set(:@docnmock_api, Docnmock::Api.new)
  end

  describe '.resource_group' do

    let(:group_name) { 'Group' }

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
        Docnmock.resource_group group_name
        expect(Docnmock.docnmock_api.resource_groups).to_not be_empty
      end
    end

    context 'a group with that name does not exist' do
      it 'creates a new group' do
        expect(Docnmock.docnmock_api.resource_groups).to be_empty
        Docnmock.resource_group group_name
        expect(Docnmock.docnmock_api.resource_groups.first.name).to eq(group_name)
      end
    end

    context 'a group with that name already exists' do
      it 'does not create a new group' do
        2.times { Docnmock.resource_group group_name }
        expect(Docnmock.docnmock_api.resource_groups.size).to eq(1)
      end
    end

  end

end

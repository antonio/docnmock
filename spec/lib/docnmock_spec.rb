require 'docnmock'

describe Docnmock do

  it { should respond_to(:define_resource_group) }
  it { should respond_to(:define_resource) }

  describe '.define_resource_group' do

    context 'with no arguments' do
      it 'raises an error' do
        expect{ Docnmock.define_resource_group }.to raise_error
      end
    end

    context 'with invalid arguments' do
      it 'raises an error' do
        expect{Docnmock.define_resource_group({})}.to raise_error
      end
    end

    context 'with valid arguments' do
      it 'creates a new group' do
        Docnmock.define_resource_group 'Users'
        expect(Docnmock.api.resource_groups).to_not be_empty
      end
    end

  end

end

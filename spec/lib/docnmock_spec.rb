require 'docnmock'

module MyModule; end
module AnotherModule; end

describe Docnmock do

  before(:all) do
    Docnmock.hook_into(MyModule)
  end

  it 'hooks itself into another module and creates a new API' do
    expect(MyModule).to be_a_kind_of(Docnmock)
  end

  it 'creates a new Api object when extending a module' do
    expect(MyModule.docnmock_api).to be_a_kind_of(Docnmock::Api)
  end

  describe '.docnmock_api' do
    it 'returns the same object for the same module' do
      expect(MyModule.docnmock_api).to be(MyModule.docnmock_api)
    end

    it 'returns a different object for a different module' do
      Docnmock.hook_into(AnotherModule)
      expect(MyModule.docnmock_api).to_not be(AnotherModule.docnmock_api)
    end

    it 'yields control' do
      expect{ |probe| MyModule.docnmock_api(&probe) }.to yield_control
    end
  end

end

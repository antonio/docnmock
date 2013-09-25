require 'spec_helper'

class Thing
  include Docnmock::Modules::Mock
end

class ThingMocker
  def mock
    42
  end
end

describe Docnmock::Modules::Mock do
  subject { Thing.new }

  it { should respond_to(:mock) }

  it 'should delegate the mock call to a mocker class' do
    # There must be a better way to do this
    expect(subject.mock).to eq(42)
  end
end

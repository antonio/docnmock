require 'spec_helper'

describe Docnmock::Resource::Example do

  describe 'initialization' do
    it 'fails with no path' do
      expect{ Docnmock::Resource::Example.new(nil, 'response') }.to raise_error
    end

    it 'fails with no response' do
      expect{ Docnmock::Resource::Example.new('/path', nil) }.to raise_error
    end
  end
end

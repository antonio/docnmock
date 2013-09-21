require 'spec_helper'

describe Docnmock::Api do

  it { should respond_to(:resource_groups) }
  it { should respond_to(:add_resource_group) }
  it { should respond_to(:each_group) }

  let(:group) { double('resource_group', touch: nil)}

  describe '#resource_groups' do
    it 'returns an Enumerable' do
      expect(subject.resource_groups.is_a?(Enumerable)).to be_true
    end
  end

  describe '#add_resource_group' do
    it 'adds a new group' do
      subject.add_resource_group(group)
      expect(subject.resource_groups).to_not be_empty
    end
  end

  describe '#each_group' do

    before(:each) do
      subject.add_resource_group(group)
    end

    it 'is delegated to the resource_groups' do
      expect(group).to receive(:touch)
      subject.each_group do |group|
        group.touch
      end
    end

  end

end

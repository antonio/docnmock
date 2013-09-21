require 'spec_helper'

describe Docnmock::Api do

  it { should respond_to(:resource_groups) }
  it { should respond_to(:each_group) }

  let(:group) { double('resource_group', name: 'users')}

  describe '#resource_groups' do
    it 'returns an Enumerable' do
      expect(subject.resource_groups).to be_a_kind_of(Enumerable)
    end
  end

  describe '#each_group' do

    before(:each) do
      subject.send(:add_resource_group, group)
    end

    it 'is delegated to the resource_groups' do
      expect(group).to receive(:name)
      subject.each_group do |group|
        group.name
      end
    end

  end

  describe '#resource_group' do

    it 'returns a group' do
      group = subject.resource_group('Group')
      expect(group).to be_an_instance_of(Docnmock::ResourceGroup)
    end

    context 'a group with the given name exists' do

      before(:each) do
        subject.send(:add_resource_group, group)
      end

      it 'does not modify the resource groups list' do
        expect(subject.resource_groups.size).to eq(1)
        subject.resource_group(group.name)
        expect(subject.resource_groups.size).to eq(1)
      end

    end

    context 'a group with the given name does not exist' do

      it 'adds it to the resource groups list' do
        expect(subject.resource_groups.size).to eq(0)
        subject.resource_group(group.name)
        expect(subject.resource_groups.size).to eq(1)
      end

    end

    it 'configures the resource block' do
      Docnmock.resource_group('Group') do
        description 'A description'
      end
      expect(Docnmock.resource_group('Group').description).to eq('A description')
    end
  end

end

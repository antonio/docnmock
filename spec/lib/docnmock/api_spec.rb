require 'spec_helper'

describe Docnmock::Api do

  it { should respond_to(:resource_groups) }
  it { should respond_to(:each_group) }
  it { should respond_to(:base_url) }

  subject { Docnmock::Api.new('http://www.example.com') }

  let(:group) { double('resource_group', name: 'users')}

  describe 'initialization' do
    it 'needs a base url' do
      expect{Docnmock::Api.new}.to raise_error
    end
  end

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

    it 'yields control' do
      expect{|probe| subject.resource_group('Group', &probe)}.to yield_control
    end

  end

  it_behaves_like 'a mockable thing'

end

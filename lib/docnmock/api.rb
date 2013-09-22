module Docnmock
  class Api

    # Internal: Returns the resource groups
    attr_reader :resource_groups

    # Internal: Initialize the Api
    def initialize
      @resource_groups ||= []
    end

    # Internal: Iterate over the resource groups
    #
    # block - The block to pass to the resource group
    #
    # Returns nothing
    def each_group(&block)
      resource_groups.each(&block)
    end

    def resource_group(name, &block)
      group = find_group(name) || create_group(name)
      group.tap { |g| g.instance_exec(&block) if block_given? }
    end

    private

    def create_group(name)
      Docnmock::ResourceGroup.new(name).tap {|g| add_resource_group g}
    end

    def find_group(name)
      resource_groups.find { |rg| rg.name == name }
    end

    def add_resource_group(group)
      @resource_groups << group
    end

  end
end

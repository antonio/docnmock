module Docnmock
  class Api
    include Docnmock::Modules::Mock

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

    # Public: Executes the block in the context of a resource group
    # The resource group will be created unless one with the same name exists
    # already
    #
    # name  - The name of the group
    # block - The block to be executed
    #
    # Returns nothing
    # Raises an error if the name is not a string or symbol
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

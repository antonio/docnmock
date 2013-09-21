module Docnmock
  class Api

    # Internal: Returns the resource groups
    attr_reader :resource_groups

    # Internal: Initialize the Api
    def initialize
      @resource_groups ||= []
    end

    # Internal: Add a new resource group
    #
    # group - The group
    #
    # Returns nothing
    def add_resource_group(group)
      @resource_groups << group
    end

    # Internal: Iterate over the resource groups
    #
    # block - The block to pass to the resource group
    #
    # Returns nothing
    def each_group(&block)
      resource_groups.each(&block)
    end
  end
end

require "docnmock/api"
require "docnmock/parameter"
require "docnmock/resource"
require "docnmock/example"
require "docnmock/resource_group"

module Docnmock

  # Public: Hooks itself into another Module adding the API documentation and
  # mocking functionality, using it as a namespace to create the API definition.
  def self.hook_into(a_module)
    a_module.extend(self)
  end

  # Internal: Initialize or return a new Api object
  #
  # Returns a new Api object
  def self.docnmock_api
    @docnmock_api ||= Docnmock::Api.new
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
  def self.resource_group(name, &block)
    docnmock_api.resource_group(name, &block)
  end

end

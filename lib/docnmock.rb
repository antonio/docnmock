require "docnmock/api"
require "docnmock/resource_group"

module Docnmock

  # Internal: Initialize or return a new Api object
  #
  # Returns a new Api object
  def self.api
    @api ||= Docnmock::Api.new
  end

  # Public: Executes the block in the context of a resource group
  # The resource group will be created unless one with the same name exists
  # already
  #
  # name - The name of the group
  #
  # Returns nothing
  # Raises an error if the name is not a string or symbol
  def self.resource_group(name)
    api.resource_group name
  end

  # Public: Creates a new resource
  #
  # Returns nothing
  def self.resource

  end

end

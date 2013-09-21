require "docnmock/api"

module Docnmock

  # Internal: Initialize or return a new Api object
  #
  # Returns a new Api object
  def self.api
    @api ||= Docnmock::Api.new
  end

  # Public: Creates a new resource group
  #
  # name - The name of the group
  #
  # Returns nothing
  # Raises an error if the name is not a string or symbol
  def self.define_resource_group(name)
    # TODO: Movel to Docnmock::ResourceGroup
    raise "Invalid group name: #{name}" unless [String, Symbol].include?(name.class)

    api.add_resource_group(name)
  end

  # Public: Creates a new resource
  #
  # Returns nothing
  def self.define_resource

  end

end

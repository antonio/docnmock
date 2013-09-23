require "docnmock/api"
require "docnmock/parameter"
require "docnmock/resource"
require "docnmock/example"
require "docnmock/resource_group"
require "docnmock/mocker"

module Docnmock

  # Public: Hooks itself into another Module adding the API documentation and
  # mocking functionality, using it as a namespace to create the API definition.
  #
  # a_module = The Ruby module Docnmock will extend
  #
  # Returns nothing
  def self.hook_into(a_module)
    a_module.extend(self)
  end

  # Internal: Initialize or return a new Api object
  #
  # block - The block to be executed in the context of the API
  #
  # Returns a new Api object
  def docnmock_api(&block)
    @docnmock_api ||= Docnmock::Api.new
    @docnmock_api.tap { |api| api.instance_exec(&block) if block_given? }
  end

end

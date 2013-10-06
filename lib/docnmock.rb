require "docnmock/modules/mock"
require "docnmock/api"
require "docnmock/parameter"
require "docnmock/resource"
require "docnmock/example"
require "docnmock/resource_group"
require "docnmock/resource_mocker"
require "docnmock/resource_group_mocker"
require "docnmock/api_mocker"

module Docnmock

  @apis = {}

  # Internal: Initialize or return a new Api object
  #
  # block - The block to be executed in the context of the API
  #
  # Returns a new Api object
  def self.api(api_url, &block)
    @apis[api_url] ||= Docnmock::Api.new(api_url)
    @apis[api_url].tap { |api| api.instance_exec(&block) if block_given? }
  end

end

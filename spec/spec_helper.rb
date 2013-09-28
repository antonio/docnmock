require 'simplecov'
SimpleCov.start

require 'pry'
require 'docnmock'
require 'webmock/rspec'

Dir["./spec/support/**/*.rb"].sort.each {|f| require f}
